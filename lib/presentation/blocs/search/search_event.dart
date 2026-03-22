part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchLoad extends SearchEvent {}

class SearchQuery extends SearchEvent {
  final String query;
  const SearchQuery(this.query);
  @override
  List<Object> get props => [query];
}

class SaveHistoryEvent extends SearchEvent {
  final String query;

  const SaveHistoryEvent(this.query);
}

class RecentSearches extends SearchEvent {}

class SearchChanged extends SearchEvent {}

class ClearSearch extends SearchEvent {}
