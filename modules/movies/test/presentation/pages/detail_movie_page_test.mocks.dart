// Mocks generated by Mockito 5.3.2 from annotations
// in movies/test/presentation/pages/detail_movie_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/movies.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetMovieDetail_0 extends _i1.SmartFake
    implements _i2.GetMovieDetail {
  _FakeGetMovieDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieState_1 extends _i1.SmartFake implements _i2.MovieState {
  _FakeMovieState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetMovieRecommendations_2 extends _i1.SmartFake
    implements _i2.GetMovieRecommendations {
  _FakeGetMovieRecommendations_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchlistMovies_3 extends _i1.SmartFake
    implements _i2.GetWatchlistMovies {
  _FakeGetWatchlistMovies_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetMovieWatchListStatus_4 extends _i1.SmartFake
    implements _i2.GetMovieWatchListStatus {
  _FakeGetMovieWatchListStatus_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveMovieWatchlist_5 extends _i1.SmartFake
    implements _i2.SaveMovieWatchlist {
  _FakeSaveMovieWatchlist_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveMovieWatchlist_6 extends _i1.SmartFake
    implements _i2.RemoveMovieWatchlist {
  _FakeRemoveMovieWatchlist_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailBloc extends _i1.Mock implements _i2.MovieDetailBloc {
  MockMovieDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail => (super.noSuchMethod(
        Invocation.getter(#getMovieDetail),
        returnValue: _FakeGetMovieDetail_0(
          this,
          Invocation.getter(#getMovieDetail),
        ),
      ) as _i2.GetMovieDetail);
  @override
  _i2.MovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.MovieState);
  @override
  _i3.Stream<_i2.MovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.MovieState>.empty(),
      ) as _i3.Stream<_i2.MovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i2.MovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.MovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.MovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.MovieEvent>(
    _i4.EventHandler<E, _i2.MovieState>? handler, {
    _i4.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i4.Transition<_i2.MovieEvent, _i2.MovieState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void onChange(_i4.Change<_i2.MovieState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MovieRecommendationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRecommendationBloc extends _i1.Mock
    implements _i2.MovieRecommendationBloc {
  MockMovieRecommendationBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(
        Invocation.getter(#getMovieRecommendations),
        returnValue: _FakeGetMovieRecommendations_2(
          this,
          Invocation.getter(#getMovieRecommendations),
        ),
      ) as _i2.GetMovieRecommendations);
  @override
  _i2.MovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.MovieState);
  @override
  _i3.Stream<_i2.MovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.MovieState>.empty(),
      ) as _i3.Stream<_i2.MovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i2.MovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.MovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.MovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.MovieEvent>(
    _i4.EventHandler<E, _i2.MovieState>? handler, {
    _i4.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i4.Transition<_i2.MovieEvent, _i2.MovieState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void onChange(_i4.Change<_i2.MovieState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MovieWatchlistBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieWatchlistBloc extends _i1.Mock
    implements _i2.MovieWatchlistBloc {
  MockMovieWatchlistBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistMovies get getWatchlistMovies => (super.noSuchMethod(
        Invocation.getter(#getWatchlistMovies),
        returnValue: _FakeGetWatchlistMovies_3(
          this,
          Invocation.getter(#getWatchlistMovies),
        ),
      ) as _i2.GetWatchlistMovies);
  @override
  _i2.GetMovieWatchListStatus get getMovieWatchListStatus =>
      (super.noSuchMethod(
        Invocation.getter(#getMovieWatchListStatus),
        returnValue: _FakeGetMovieWatchListStatus_4(
          this,
          Invocation.getter(#getMovieWatchListStatus),
        ),
      ) as _i2.GetMovieWatchListStatus);
  @override
  _i2.SaveMovieWatchlist get saveMovieWatchlist => (super.noSuchMethod(
        Invocation.getter(#saveMovieWatchlist),
        returnValue: _FakeSaveMovieWatchlist_5(
          this,
          Invocation.getter(#saveMovieWatchlist),
        ),
      ) as _i2.SaveMovieWatchlist);
  @override
  _i2.RemoveMovieWatchlist get removeMovieWatchlist => (super.noSuchMethod(
        Invocation.getter(#removeMovieWatchlist),
        returnValue: _FakeRemoveMovieWatchlist_6(
          this,
          Invocation.getter(#removeMovieWatchlist),
        ),
      ) as _i2.RemoveMovieWatchlist);
  @override
  _i2.MovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.MovieState);
  @override
  _i3.Stream<_i2.MovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.MovieState>.empty(),
      ) as _i3.Stream<_i2.MovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i2.MovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.MovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.MovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.MovieEvent>(
    _i4.EventHandler<E, _i2.MovieState>? handler, {
    _i4.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i4.Transition<_i2.MovieEvent, _i2.MovieState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void onChange(_i4.Change<_i2.MovieState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}