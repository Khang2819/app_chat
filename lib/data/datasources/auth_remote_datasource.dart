import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/users_model.dart';

abstract class AuthRemoteDataSource {
  Future<UsersModel> login(String email, String password);
  Future<UsersModel> register(String fullName, String email, String password);
  Future<void> logout();
  Stream<UsersModel?> get user;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<UsersModel?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      final doc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      return UsersModel.fromMap(doc.data()!);
    });
  }

  @override
  Future<UsersModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDoc =
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();
      return UsersModel.fromMap(userDoc.data()!);
    } catch (e) {
      throw Exception("Đã có lỗi xảy ra, vui lòng thử lại.");
    }
  }

  @override
  Future<UsersModel> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userData = {'email': email, 'full_name': fullName};

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userData);
      return UsersModel.fromMap(userData);
    } catch (e) {
      throw Exception("Đã có lỗi xảy ra, vui lòng thử lại.");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Đã có lỗi xảy ra, vui long thử lại');
    }
  }
}
