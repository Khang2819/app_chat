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
      fromId: map['fromId'] as String? ?? '',
      fullName: userMap['full_name'] as String? ?? '',
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
      status: map['status'] as String? ?? 'pending',
      avatar: userMap['avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromId': fromId,
      'full_name': fullName,
      'createdAt': createdAt,
      'status': status,
      'avatar': avatar,
    };
  }
}
