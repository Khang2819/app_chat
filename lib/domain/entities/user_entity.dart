import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String? avatar;
  final bool isOnline;
  final String userName;
  final DateTime? lastSeen;
  const UserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    this.avatar,
    required this.isOnline,
    required this.userName,
    this.lastSeen,
  });
  @override
  List<Object?> get props => [userId, fullName, email, avatar, isOnline];
}
