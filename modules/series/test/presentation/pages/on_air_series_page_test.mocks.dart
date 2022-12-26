// Mocks generated by Mockito 5.3.2 from annotations
// in series/test/presentation/pages/on_air_series_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:series/series.dart' as _i2;

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

class _FakeSeriesState_1 extends _i1.SmartFake implements _i2.SeriesState {
  _FakeSeriesState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OnAirSeriesBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockOnAirSeriesBloc extends _i1.Mock implements _i2.OnAirSeriesBloc {
  MockOnAirSeriesBloc() {
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
  _i2.SeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeSeriesState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.SeriesState);
  @override
  _i3.Stream<_i2.SeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.SeriesState>.empty(),
      ) as _i3.Stream<_i2.SeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i2.SeriesEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.SeriesEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.SeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.SeriesEvent>(
    _i4.EventHandler<E, _i2.SeriesState>? handler, {
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
          _i4.Transition<_i2.SeriesEvent, _i2.SeriesState>? transition) =>
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
  void onChange(_i4.Change<_i2.SeriesState>? change) => super.noSuchMethod(
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
