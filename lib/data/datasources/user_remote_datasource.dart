import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../models/users_model.dart';

abstract class UserRemoteDatasource {
  Stream<List<UserEntity>> getAllFrends();
  Future<UserEntity> getUserById(String userId);
  Future<List<UserEntity>> searchUsers(String query);
  Future<List<String>> getSearchHistory(String userId);
  Future<void> saveSearchQuery(String userId, String query);
  Future<void> clearSearchHistory(String userId);
}

class UserRemoteDatasourceImpl extends UserRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Stream<List<UserEntity>> getAllFrends() {
    return _auth.authStateChanges().switchMap((user) {
      if (user == null) return Stream.value(<UserEntity>[]);
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('friends')
          .snapshots()
          .map((snapshot) {
            final friends =
                snapshot.docs
                    .map((doc) => UsersModel.fromMap(doc.data()))
                    .toList();

            friends.sort((a, b) {
              if (a.isOnline == b.isOnline) return 0;
              return a.isOnline ? -1 : 1;
            });
            return friends;
          });
    });
  }

  @override
  Future<UserEntity> getUserById(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return UsersModel.fromMap(doc.data()!);
    } else {
      throw Exception("Người dùng không tồn tại");
    }
  }

  @override
  Future<List<UserEntity>> searchUsers(String query) async {
    final snapshot =
        await _firestore
            .collection('users')
            .where('userName', isGreaterThanOrEqualTo: query)
            .where('userName', isLessThanOrEqualTo: '$query\uf8ff')
            .get();
    return snapshot.docs.map((doc) => UsersModel.fromMap(doc.data())).toList();
  }

  @override
  Future<List<String>> getSearchHistory(String userId) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList('search_history_$userId') ?? [];
  }

  @override
  Future<void> saveSearchQuery(String userId, String query) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'search_history_$userId';
    List<String> history = pref.getStringList(key) ?? [];
    history.remove(query);
    history.insert(0, query);
    if (history.length > 10) history = history.sublist(0, 10);
    await pref.setStringList(key, history);
  }

  @override
  Future<void> clearSearchHistory(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history_$userId');
  }
}
