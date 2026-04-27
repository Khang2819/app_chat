import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String? avatar;
  final bool isOnline;
  final String userName;
  final DateTime? requestAt;
  final DateTime? lastSeen;
  const UserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    this.avatar,
    required this.isOnline,
    required this.userName,
    this.lastSeen,
    this.requestAt,
  });
  @override
  List<Object?> get props => [
    userId,
    fullName,
    email,
    avatar,
    isOnline,
    requestAt,
  ];
}
