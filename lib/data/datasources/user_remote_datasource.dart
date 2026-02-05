import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';
import '../models/users_model.dart';

abstract class UserRemoteDatasource {
  Stream<List<UserEntity>> getAllFrends();
  Future<void> sendFriendRequest(String targetUserId);
  Future<void> acceptFriendRequest(String requesterId);
  Future<void> deleteFriendRequest(String requesterId);
  Stream<List<UserEntity>> getIncomingRequests();
}

class UserRemoteDatasourceImpl extends UserRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Stream<List<UserEntity>> getAllFrends() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('friends')
        .snapshots()
        .map((snapshot) {
          final friends =
              snapshot.docs
                  .map((doc) => UsersModel.fromMap(doc.data()))
                  .toList();
          friends.sort((a, b) {
            if (a.isOnline == b.isOnline) {
              return 0;
            }
            return a.isOnline ? -1 : 1;
          });
          return friends;
        });
  }

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
  Stream<List<UserEntity>> getIncomingRequests() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('friend_requests')
        .snapshots()
        .asyncMap((snapshot) async {
          List<UserEntity> requesters = [];
          for (var doc in snapshot.docs) {
            final fromId = doc.data()['fromId'];
            final userDoc =
                await _firestore.collection('users').doc(fromId).get();
            if (userDoc.exists) {
              requesters.add(UsersModel.fromMap(userDoc.data()!));
            }
          }
          return requesters;
        });
  }
}
