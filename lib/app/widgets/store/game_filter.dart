import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';

import '../../services/rest_service.dart';

abstract class GameFilter {
  static RestService restService = Modular.get<RestService>();
  final String title;

  const GameFilter({required this.title});

  Future<List<ShortGameModel>> getGames();
}

class AllGamesFilter extends GameFilter {
  const AllGamesFilter() : super(title: 'All Games');

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames();
  }
}

class ReleaseDateFilter extends GameFilter {
  final String releaseDate;

  const ReleaseDateFilter({required super.title, required this.releaseDate});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(releaseDate: releaseDate);
  }
}

class PlayTimeFilter extends GameFilter {
  final int playTime;

  const PlayTimeFilter({required super.title, required this.playTime});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(playTime: playTime);
  }
}

class IsFreeFilter extends GameFilter {
  const IsFreeFilter({required super.title});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(isFree: true);
  }
}

class StoresFilter extends GameFilter {
  final String stores;

  const StoresFilter({required super.title, required this.stores});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(stores: stores);
  }
}

class DeveloperFilter extends GameFilter {
  final String developer;

  const DeveloperFilter({required super.title, required this.developer});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(developer: developer);
  }
}

class GenresFilter extends GameFilter {
  final String genres;

  const GenresFilter({required super.title, required this.genres});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(genres: genres);
  }
}

class PublisherFilter extends GameFilter {
  final String publisher;

  const PublisherFilter({required super.title, required this.publisher});

  @override
  Future<List<ShortGameModel>> getGames() {
    return GameFilter.restService.getGames(publisher: publisher);
  }
}
