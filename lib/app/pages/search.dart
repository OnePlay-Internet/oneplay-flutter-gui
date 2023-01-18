import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/game_row/game_row.dart';
import 'package:oneplay_flutter_gui/app/widgets/user_row/user_row.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final RestService _restService = Modular.get<RestService>();
  bool loading = false;
  List<ShortGameModel> games = [];
  List<ShortUserModel> users = [];
  String keyword = '';
  String keywordHash = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextField(
                controller: _controller,
                key: widget.key,
                cursorColor: whiteColor1,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => _search(),
                style: const TextStyle(
                  color: greyColor2,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: blackColor3,
                  filled: true,
                  hintText: "Search for game or friends",
                  hintStyle: const TextStyle(
                    color: greyColor2,
                    fontSize: 16,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _search();
                    },
                    icon: const Icon(Icons.search, color: greyColor2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (games.isNotEmpty) _titleText('Games'),
                    ...games.map((e) => gameRow(e)),
                    if (games.isNotEmpty)
                      _seeAllBtn(
                        context,
                        onTap: () => Modular.to
                            .pushNamed('/search/games?q=${_controller.text}'),
                        text: "See more games",
                      ),
                    if (users.isNotEmpty) _titleText('People'),
                    ...users.map((e) => UserRow(user: e)),
                    if (users.isNotEmpty)
                      _seeAllBtn(
                        context,
                        onTap: () => Modular.to
                            .pushNamed('/search/users?q=${_controller.text}'),
                        text: "See more people",
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _titleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: greyColor1,
          fontSize: 16,
        ),
      ),
    );
  }

  Padding _seeAllBtn(
    BuildContext context, {
    required Function()? onTap,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            gradient: const LinearGradient(
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
              colors: [blackColor1, blackColor2],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.02,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _search();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _search() async {
    setState(() => loading = true);

    try {
      await Future.wait([
        _restService
            .searchGames(
          query: _controller.text,
          page: 0,
          limit: 3,
        )
            .then((res) {
          setState(() => games = res.results);
          keyword = res.keyword;
          keywordHash = res.keywordHash;
        }),
        _restService
            .searchUsers(
          query: _controller.text,
          page: 0,
          limit: 3,
        )
            .then((value) {
          setState(() => users = value);
        }),
      ]);
    } on DioError catch (e) {
    } finally {
      setState(() => loading = false);
    }
  }
}
