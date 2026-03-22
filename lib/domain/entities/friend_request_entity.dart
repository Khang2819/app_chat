import 'package:equatable/equatable.dart';

class FriendRequestEntity extends Equatable {
  final String fromId;
  final String fullName;
  final String? avatar;
  final DateTime createdAt;
  final String status;

  const FriendRequestEntity({
    required this.fromId,
    required this.fullName,
    this.avatar,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [fromId, status, createdAt];
}
