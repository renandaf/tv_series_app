import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_object.dart';
import 'watchlist_series_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlist, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late SeriesWatchlistBloc seriesWatchlistBloc;
  late MockGetWatchlist mockGetWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(
    () {
      mockGetWatchlist = MockGetWatchlist();
      mockGetWatchListStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      seriesWatchlistBloc = SeriesWatchlistBloc(mockGetWatchListStatus,
          mockGetWatchlist, mockRemoveWatchlist, mockSaveWatchlist);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(seriesWatchlistBloc.state, SeriesEmpty());
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetWatchlist.execute())
          .thenAnswer((realInvocation) async => Right(detailList));
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSeriesWatchlist()),
    expect: () => <SeriesState>[
      SeriesLoading(),
      WatchlistSeriesHasData(detailList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, Error] when get watchlist series is unsuccessful.',
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer((realInvocation) async =>
          const Left(DatabaseFailure("Failed to Get Data")));
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSeriesWatchlist()),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError("Failed to Get Data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, SeriesWatchlistStatus] when status is gotten successfully.',
    build: () {
      when(mockGetWatchListStatus.execute(detail.id))
          .thenAnswer((realInvocation) async => true);
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSeriesWatchlistStatus(detail.id!)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(detail.id));
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, SeriesWatchlistMessage] when add series to watchlist is successfully.',
    build: () {
      when(mockSaveWatchlist.execute(detail)).thenAnswer(
          (realInvocation) async =>
              const Right(SeriesWatchlistBloc.watchlistAddSuccesMessage));
      when(mockGetWatchListStatus.execute(detail.id))
          .thenAnswer((realInvocation) async => true);
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnAddSeriesWatchlist(detail)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesWatchlistMessage(
          SeriesWatchlistBloc.watchlistAddSuccesMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(detail));
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, Error] when add series to watchlist is unsuccessful.',
    build: () {
      when(mockSaveWatchlist.execute(detail)).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(detail.id))
          .thenAnswer((realInvocation) async => false);
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnAddSeriesWatchlist(detail)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(detail));
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, SeriesWatchlistMessage] when remove movie from watchlist is successfully.',
    build: () {
      when(mockRemoveWatchlist.execute(detail)).thenAnswer(
          (realInvocation) async =>
              const Right(SeriesWatchlistBloc.watchlistRemoveSuccesMessage));
      when(mockGetWatchListStatus.execute(detail.id))
          .thenAnswer((realInvocation) async => false);
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveSeriesWatchlist(detail)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesWatchlistMessage(
          SeriesWatchlistBloc.watchlistRemoveSuccesMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(detail));
    },
  );

  blocTest<SeriesWatchlistBloc, SeriesState>(
    'emits [Loading, Error] when remove movie from watchlist is unsuccessful.',
    build: () {
      when(mockRemoveWatchlist.execute(detail)).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(detail.id))
          .thenAnswer((realInvocation) async => true);
      return seriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveSeriesWatchlist(detail)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(detail));
    },
  );
}
