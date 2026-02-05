import 'package:app_chat/domain/entities/friends_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsModel extends FriendsEntity {
  const FriendsModel({
    required super.userId,
    required super.email,
    required super.fullName,
    super.avatar,
    required super.isOnline,
    required super.userName,
    super.lastSeen,
  });

  factory FriendsModel.fromMap(Map<String, dynamic> map) {
    return FriendsModel(
      userId: map['userId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      fullName: map['full_name'] as String? ?? '',
      isOnline: map['isOnline'] as bool? ?? false,
      userName: map['userName'] as String? ?? '',
      lastSeen:
          map['last_name'] != null
              ? (map['last_name'] as Timestamp).toDate()
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
