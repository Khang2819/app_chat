import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/friend_request_entity.dart';
import '../models/friend_request_model.dart';

abstract class FriendRemoteDatasource {
  Future<void> sendFriendRequest(String targetUserId);
  Future<void> acceptFriendRequest(String requesterId);
  Future<void> deleteFriendRequest(String requesterId);
  Stream<List<FriendRequestEntity>> getIncomingRequests();
}

class FriendRemoteDatasourceImpl extends FriendRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> sendFriendRequest(String targetUserId) async {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;
    await _firestore
        .collection('users')
        .doc(targetUserId)
        .collection('friend_requests')
        .doc(currentUserId)
        .set({
          'fromId': currentUserId,
          'status': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<void> acceptFriendRequest(String requesterId) async {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;
    final batch = _firestore.batch();

    final requesterDoc =
        await _firestore.collection('users').doc(requesterId).get();
    batch.set(
      _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('friends')
          .doc(requesterId),
      requesterDoc.data()!,
    );

    final currentUserDoc =
        await _firestore.collection('users').doc(currentUserId).get();
    batch.set(
      _firestore
          .collection('users')
          .doc(requesterId)
          .collection('friends')
          .doc(currentUserId),
      currentUserDoc.data()!,
    );

    batch.delete(
      _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('friend_requests')
          .doc(requesterId),
    );
    await batch.commit();
  }

  @override
  Future<void> deleteFriendRequest(String requesterId) async {
    final currentUserId = _auth.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('friend_requests')
        .doc(requesterId)
        .delete();
  }

  @override
  Stream<List<FriendRequestEntity>> getIncomingRequests() {
    return _auth.authStateChanges().switchMap((user) {
      if (user == null) return Stream.value(<FriendRequestEntity>[]);
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('friend_requests')
          .snapshots()
          .asyncMap((snapshot) async {
            if (_auth.currentUser == null) return <FriendRequestEntity>[];
            List<FriendRequestEntity> requesters = [];
            for (var doc in snapshot.docs) {
              if (_auth.currentUser == null) break;
              final fromId = doc.data()['fromId'];
              final userDoc =
                  await _firestore.collection('users').doc(fromId).get();
              if (userDoc.exists) {
                requesters.add(
                  FriendRequestModel.fromMap(doc.data(), userDoc.data()!),
                );
              }
            }
            requesters.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return requesters;
          });
    });
    //
  }
}
