import 'dart:async';

import 'package:app_chat/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositories/user_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserRepository userRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SearchBloc({required this.userRepository}) : super(SearchInitial()) {
    on<SearchQuery>(_onSearchQuery);
    on<ClearSearch>(_onClearSearch);
    on<SearchLoad>(_onLoadHistory);
    on<SaveHistoryEvent>(_onSaveHistoryEvent);
  }

  FutureOr<void> _onSearchQuery(
    SearchQuery event,
    Emitter<SearchState> emit,
  ) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    if (event.query.isEmpty) {
      final history = await userRepository.getSearchHistory(userId);
      emit(SearchLoaded(const [], recentQueries: history));
      return;
    }
    emit(SearchLoading());
    try {
      final history = await userRepository.getSearchHistory(userId);
      final users = await userRepository.searchUsers(event.query);
      emit(SearchLoaded(users, recentQueries: history));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  FutureOr<void> _onLoadHistory(
    SearchLoad event,
    Emitter<SearchState> emit,
  ) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final history = await userRepository.getSearchHistory(userId);
    emit(SearchLoaded(const [], recentQueries: history));
  }

  FutureOr<void> _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      await userRepository.clearSearchHistory(userId);
    }
    emit(SearchInitial());
  }

  FutureOr<void> _onSaveHistoryEvent(
    SaveHistoryEvent event,
    Emitter<SearchState> emit,
  ) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null && event.query.isNotEmpty) {
      await userRepository.saveSearchQuery(userId, event.query);
    }
  }
}
