import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/friend_request_entity.dart';

class FriendRequestModel extends FriendRequestEntity {
  const FriendRequestModel({
    required super.fromId,
    required super.fullName,
    super.avatar,
    required super.createdAt,
    required super.status,
  });
  factory FriendRequestModel.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic> userMap,
  ) {
    return FriendRequestModel(
      fromId: map['fromId'] ?? '',
      fullName: userMap['full_name'],
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
      status: map['status'] ?? 'pending',
      avatar: userMap['avatar'],
    );
  }
}
