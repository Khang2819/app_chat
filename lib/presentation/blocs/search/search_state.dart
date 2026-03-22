part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<UserEntity> users;
  final List<String> recentQueries;
  const SearchLoaded(this.users, {this.recentQueries = const []});
  @override
  List<Object> get props => [users, recentQueries];
}

final class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
  @override
  List<Object> get props => [message];
}
