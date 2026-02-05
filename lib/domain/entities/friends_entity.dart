import 'package:equatable/equatable.dart';

class FriendsEntity extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String? avatar;
  final bool isOnline;
  final String userName;
  final DateTime? lastSeen;
  const FriendsEntity({
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
