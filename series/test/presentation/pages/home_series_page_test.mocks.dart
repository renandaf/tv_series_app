// Mocks generated by Mockito 5.3.2 from annotations
// in series/test/presentation/pages/home_series_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:core/core.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:series/domain/entities/series.dart' as _i6;
import 'package:series/domain/usecases/get_on_air_series.dart' as _i2;
import 'package:series/domain/usecases/get_popular_series.dart' as _i3;
import 'package:series/domain/usecases/get_top_rated_series.dart' as _i4;
import 'package:series/presentation/provider/series_list_notifier.dart' as _i5;

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

class _FakeGetOnAirSeries_0 extends _i1.SmartFake
    implements _i2.GetOnAirSeries {
  _FakeGetOnAirSeries_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetPopularSeries_1 extends _i1.SmartFake
    implements _i3.GetPopularSeries {
  _FakeGetPopularSeries_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTopRatedSeries_2 extends _i1.SmartFake
    implements _i4.GetTopRatedSeries {
  _FakeGetTopRatedSeries_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SeriesListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesListNotifier extends _i1.Mock
    implements _i5.SeriesListNotifier {
  MockSeriesListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetOnAirSeries get getOnAirSeries => (super.noSuchMethod(
        Invocation.getter(#getOnAirSeries),
        returnValue: _FakeGetOnAirSeries_0(
          this,
          Invocation.getter(#getOnAirSeries),
        ),
      ) as _i2.GetOnAirSeries);
  @override
  _i3.GetPopularSeries get getPopularSeries => (super.noSuchMethod(
        Invocation.getter(#getPopularSeries),
        returnValue: _FakeGetPopularSeries_1(
          this,
          Invocation.getter(#getPopularSeries),
        ),
      ) as _i3.GetPopularSeries);
  @override
  _i4.GetTopRatedSeries get getTopRatedSeries => (super.noSuchMethod(
        Invocation.getter(#getTopRatedSeries),
        returnValue: _FakeGetTopRatedSeries_2(
          this,
          Invocation.getter(#getTopRatedSeries),
        ),
      ) as _i4.GetTopRatedSeries);
  @override
  List<_i6.Series> get onAirSeries => (super.noSuchMethod(
        Invocation.getter(#onAirSeries),
        returnValue: <_i6.Series>[],
      ) as List<_i6.Series>);
  @override
  _i7.RequestState get onAirState => (super.noSuchMethod(
        Invocation.getter(#onAirState),
        returnValue: _i7.RequestState.empty,
      ) as _i7.RequestState);
  @override
  List<_i6.Series> get popularSeries => (super.noSuchMethod(
        Invocation.getter(#popularSeries),
        returnValue: <_i6.Series>[],
      ) as List<_i6.Series>);
  @override
  _i7.RequestState get popularSeriesState => (super.noSuchMethod(
        Invocation.getter(#popularSeriesState),
        returnValue: _i7.RequestState.empty,
      ) as _i7.RequestState);
  @override
  List<_i6.Series> get topRatedSeries => (super.noSuchMethod(
        Invocation.getter(#topRatedSeries),
        returnValue: <_i6.Series>[],
      ) as List<_i6.Series>);
  @override
  _i7.RequestState get topRatedSeriesState => (super.noSuchMethod(
        Invocation.getter(#topRatedSeriesState),
        returnValue: _i7.RequestState.empty,
      ) as _i7.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchOnAirSeries() => (super.noSuchMethod(
        Invocation.method(
          #fetchOnAirSeries,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchPopularSeries() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularSeries,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchTopRatedSeries() => (super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedSeries,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
