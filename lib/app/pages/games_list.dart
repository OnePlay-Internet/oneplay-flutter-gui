import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/game_row/game_row.dart';
import 'package:oneplay_flutter_gui/app/widgets/gamepad_pop/gamepad_pop.dart';

class GamesList extends StatefulWidget {
  final String query;

  const GamesList({
    super.key,
    required this.query,
  });

  @override
  State<GamesList> createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  final RestService _restService = Modular.get<RestService>();
  List<ShortGameModel> games = [];
  String keyword = '';
  String keywordHash = '';
  int page = 0;
  bool loading = false;
  bool hasMore = true;

  @override
  Widget build(BuildContext context) {
    return GamepadPop(
      context: context,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.query.trim() == ''
                  ? 'All games'
                  : 'You searched for "${widget.query}"',
              style: const TextStyle(
                color: textSecondaryColor,
                fontSize: 20,
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: hasMore ? games.length + 1 : games.length,
              itemBuilder: ((context, index) {
                if (index < games.length) {
                  return gameRow(games[index]);
                } else {
                  _onLoad();
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    _onLoad();
    super.initState();
  }

  _onLoad() async {
    if (loading || !hasMore) {
      return;
    }

    loading = true;

    try {
      final res = await _restService.searchGames(
        query: widget.query,
        page: page,
        limit: 10,
      );
      setState(() {
        games = [...games, ...res.results];
        if (res.results.length < 10) hasMore = false;
      });
      keyword = res.keyword;
      keywordHash = res.keywordHash;
      page++;
    } finally {
      loading = false;
    }
  }
}
