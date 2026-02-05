import 'package:app_chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel extends UserEntity {
  const UsersModel({
    required super.userId,
    required super.email,
    required super.fullName,
    super.avatar,
    required super.isOnline,
    required super.userName,
    super.lastSeen,
  });
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      userId: map['userId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      fullName: map['full_name'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      isOnline: map['isOnline'] as bool? ?? false,
      userName: map['userName'] as String? ?? '',
      lastSeen:
          map['last_seen'] != null
              ? (map['last_seen'] as Timestamp).toDate()
              : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'email': email,
    'full_name': fullName,
    'avatar': avatar,
    'is_online': isOnline,
    'username': userName,
    'last_seen': lastSeen,
  };
}
