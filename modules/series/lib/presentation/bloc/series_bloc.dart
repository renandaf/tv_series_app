import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/series.dart';

part 'series_event.dart';
part 'series_state.dart';

class SeasonDetailBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeason getSeasonDetail;
  SeasonDetailBloc(this.getSeasonDetail) : super(SeriesEmpty()) {
    on<OnSeasonDetail>((event, emit) async {
      final id = event.id;
      final season = event.season;
      emit(SeriesLoading());

      final seasonDetailResult = await getSeasonDetail.execute(id, season);
      seasonDetailResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (seasonData) => emit(
          SeasonHasData(seasonData),
        ),
      );
    });
  }
}

class SearchSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final SearchSeries searchSeries;
  SearchSeriesBloc(this.searchSeries) : super(SeriesEmpty()) {
    on<OnQuerySeriesChanged>((event, emit) async {
      final query = event.query;
      emit(SeriesLoading());
      final searchSeriessResult = await searchSeries.execute(query);
      searchSeriessResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (seriesData) => emit(
          SeriesListHasData(seriesData),
        ),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class OnAirSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetOnAirSeries getOnAirSeries;

  OnAirSeriesBloc(this.getOnAirSeries) : super(SeriesEmpty()) {
    on<OnOnAirSeries>((event, emit) async {
      emit(SeriesLoading());

      final getOnAirSeriesResult = await getOnAirSeries.execute();

      getOnAirSeriesResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (seriesData) => emit(
          SeriesListHasData(seriesData),
        ),
      );
    });
  }
}

class PopularSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetPopularSeries getPopularSeries;

  PopularSeriesBloc(this.getPopularSeries) : super(SeriesEmpty()) {
    on<OnPopularSeries>((event, emit) async {
      emit(SeriesLoading());

      final getPopularSeriessResult = await getPopularSeries.execute();

      getPopularSeriessResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (seriesData) => emit(
          SeriesListHasData(seriesData),
        ),
      );
    });
  }
}

class TopRatedSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesBloc(this.getTopRatedSeries) : super(SeriesEmpty()) {
    on<OnTopRatedSeries>((event, emit) async {
      emit(SeriesLoading());

      final getTopRatedSeriesResult = await getTopRatedSeries.execute();

      getTopRatedSeriesResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (seriesData) => emit(
          SeriesListHasData(seriesData),
        ),
      );
    });
  }
}

class SeriesDetailBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeriesDetail getSeriesDetail;

  SeriesDetailBloc(this.getSeriesDetail) : super(SeriesEmpty()) {
    on<OnDetailSeries>((event, emit) async {
      final id = event.id;

      emit(SeriesLoading());

      final getSeriesDetailResult = await getSeriesDetail.execute(id);

      getSeriesDetailResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (series) => emit(
          DetailHasData(series),
        ),
      );
    });
  }
}

class SeriesRecommendationBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeriesRecommendations getSeriesRecommendations;

  SeriesRecommendationBloc(this.getSeriesRecommendations)
      : super(SeriesEmpty()) {
    on<OnSeriesRecommendation>((event, emit) async {
      final id = event.id;
      emit(SeriesLoading());
      final getSeriesRecommendationsResult =
          await getSeriesRecommendations.execute(id);
      getSeriesRecommendationsResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (recom) => emit(
          SeriesListHasData(recom),
        ),
      );
    });
  }
}

class SeriesWatchlistBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetWatchlist getWatchlistSeries;
  final GetWatchListStatus getSeriesWatchListStatus;
  final SaveWatchlist saveSeriesWatchlist;
  final RemoveWatchlist removeSeriesWatchlist;

  static const watchlistAddSuccesMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccesMessage = 'Removed from Watchlist';

  SeriesWatchlistBloc(
    this.getSeriesWatchListStatus,
    this.getWatchlistSeries,
    this.removeSeriesWatchlist,
    this.saveSeriesWatchlist,
  ) : super(SeriesEmpty()) {
    on<OnSeriesWatchlist>((event, emit) async {
      emit(SeriesLoading());
      final getSeriesWatchlistResult = await getWatchlistSeries.execute();
      getSeriesWatchlistResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (data) => emit(
          WatchlistSeriesHasData(data),
        ),
      );
    });

    on<OnSeriesWatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(SeriesLoading());

      final getSeriesWatchlistStatusResult =
          await getSeriesWatchListStatus.execute(id);
      emit(SeriesWatchlistStatus(getSeriesWatchlistStatusResult));
    });

    on<OnAddSeriesWatchlist>((event, emit) async {
      final series = event.seriesDetail;

      emit(SeriesLoading());

      final getAddSeriesWatchlistResult =
          await saveSeriesWatchlist.execute(series);

      getAddSeriesWatchlistResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (successMessage) => emit(
          SeriesWatchlistMessage(successMessage),
        ),
      );
    });

    on<OnRemoveSeriesWatchlist>((event, emit) async {
      final series = event.seriesDetail;

      emit(SeriesLoading());

      final getRemoveSeriesWatchlistResult =
          await removeSeriesWatchlist.execute(series);

      getRemoveSeriesWatchlistResult.fold(
        (failure) => emit(
          SeriesError(failure.message),
        ),
        (successMessage) => emit(
          SeriesWatchlistMessage(successMessage),
        ),
      );
    });
  }
}
