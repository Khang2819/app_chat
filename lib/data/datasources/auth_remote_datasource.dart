import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/users_model.dart';

abstract class AuthRemoteDataSource {
  Future<UsersModel> login(String email, String password);
  Future<UsersModel> register(String fullName, String email, String password);
  Future<UsersModel> google();
  Future<void> logout();
  Stream<UsersModel?> get user;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<UsersModel?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }
      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();
      return UsersModel.fromMap(userDoc.data()!);
    });
  }

  @override
  Future<UsersModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).update(
        {'isOnline': true},
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
      final userData = {
        'userId': userCredential.user!.uid,
        'email': email,
        'full_name': fullName,
        'isOnline': true,
        'userName': email.split('@')[0],
      };

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
  Future<UsersModel> google() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception("Đã hủy đăng nhập Google");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        final userData = {
          'userId': user.uid,
          'email': user.email ?? '',
          'full_name': user.displayName ?? 'Google User',
          'avatar': user.photoURL ?? '',
          'isOnline': true,
          'userName': user.email?.split('@')[0] ?? 'user',
        };

        if (!userDoc.exists) {
          await _firestore.collection('users').doc(user.uid).set(userData);
        } else {
          await _firestore.collection('users').doc(user.uid).update({
            'isOnline': true,
          });
        }

        return UsersModel.fromMap(userData);
      }
      throw Exception("Không thể lấy thông tin người dùng từ Firebase");
    } catch (e) {
      throw Exception("Lỗi đăng nhập Google: $e");
    }
  }

  @override
  Future<void> logout() async {
    final uid = _firebaseAuth.currentUser?.uid;
    try {
      await _firebaseAuth.signOut();
      if (uid != null) {
        await _firestore.collection('users').doc(uid).update({
          'isOnline': false,
        });
      }
    } catch (e) {
      throw Exception('Đã có lỗi xảy ra, vui long thử lại');
    }
  }
}
