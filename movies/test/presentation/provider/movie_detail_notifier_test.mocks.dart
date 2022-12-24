// Mocks generated by Mockito 5.3.2 from annotations
// in movies/test/presentation/provider/movie_detail_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/core.dart' as _i9;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart' as _i10;
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/repositories/movie_repository.dart' as _i3;
import 'package:movies/domain/usecases/get_movie_detail.dart' as _i4;
import 'package:movies/domain/usecases/get_movie_recommendations.dart' as _i6;
import 'package:movies/domain/usecases/get_movie_watchlist_status.dart' as _i7;
import 'package:movies/domain/usecases/remove_movie_watchlist.dart' as _i11;
import 'package:movies/domain/usecases/save_watchlist.dart' as _i8;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieRepository_1 extends _i1.SmartFake
    implements _i3.MovieRepository {
  _FakeMovieRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetMovieDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieDetail extends _i1.Mock implements _i4.GetMovieDetail {
  MockGetMovieDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<Failure, MovieDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<Failure, MovieDetail>>.value(
            _FakeEither_0<Failure, MovieDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<Failure, MovieDetail>>);
}

/// A class which mocks [GetMovieRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieRecommendations extends _i1.Mock
    implements _i6.GetMovieRecommendations {
  MockGetMovieRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<Failure, List<Movie>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<Failure, List<Movie>>>.value(
            _FakeEither_0<Failure, List<Movie>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<Failure, List<Movie>>>);
}

/// A class which mocks [GetMovieWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieWatchListStatus extends _i1.Mock
    implements _i7.GetMovieWatchListStatus {
  MockGetMovieWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [SaveMovieWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveMovieWatchlist extends _i1.Mock
    implements _i8.SaveMovieWatchlist {
  MockSaveMovieWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMovieRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.MovieRepository);
  @override
  _i5.Future<_i2.Either<_i9.Failure, String>> execute(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Failure, String>>);
}

/// A class which mocks [RemoveMovieWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveMovieWatchlist extends _i1.Mock
    implements _i11.RemoveMovieWatchlist {
  MockRemoveMovieWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMovieRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.MovieRepository);
  @override
  _i5.Future<_i2.Either<_i9.Failure, String>> execute(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Failure, String>>);
}
