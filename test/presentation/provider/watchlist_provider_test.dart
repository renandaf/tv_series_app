import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/usecases/add_watchlist.dart';
import 'package:tv_series_app/domain/usecases/get_watchlist.dart';
import 'package:tv_series_app/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series_app/domain/usecases/remove_watchlist.dart';
import 'package:tv_series_app/presentation/provider/watchlist_provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'watchlist_provider_test.mocks.dart';

@GenerateMocks(
    [GetWatchlist, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchListNotifier provider;
  late MockGetWatchlist mockGetWatchlist;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlist = MockGetWatchlist();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = WatchListNotifier(
        getWatchlistSeries: mockGetWatchlist,
        getWatchListStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => Right([watchlist]));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistSeries, [watchlist]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(3)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(3);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(detail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(detail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(detail);
      // assert
      verify(mockSaveWatchlist.execute(detail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(detail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(detail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(detail);
      // assert
      verify(mockRemoveWatchlist.execute(detail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(detail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(detail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(detail);
      // assert
      verify(mockGetWatchlistStatus.execute(detail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.message, 'Added to Watchlist');
      expect(listenerCallCount, 3);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(detail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(detail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(detail);
      // assert
      expect(provider.message, 'Failed');
      expect(listenerCallCount, 3);
    });
  });
}
