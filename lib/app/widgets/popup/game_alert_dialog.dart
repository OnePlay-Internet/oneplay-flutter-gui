// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/common.dart';
import '../../models/game_model.dart';
import '../../services/auth_service.dart';
import '../../services/rest_service.dart';
import '../Submit_Button/submit_button.dart';
import '../focus_zoom/focus_zoom.dart';

class GameAlertDialog extends StatefulWidget {
  const GameAlertDialog({super.key});

  @override
  State<GameAlertDialog> createState() => _GameAlertDialogState();
}

class _GameAlertDialogState extends State<GameAlertDialog> {
  final searchController = TextEditingController();
  final RestService _restService = Modular.get<RestService>();
  List<ShortGameModel> games = [];
  String keyword = '';
  String keywordHash = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double itemHeight = size.height * 0.13;
    double itemWidth = size.width / 2.0;

    return AlertDialog(
      backgroundColor: mainColor,
      contentPadding: const EdgeInsets.all(0.0),
      insetPadding: EdgeInsets.all(
        size.width * 0.03,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select The Games',
                style: TextStyle(
                  fontFamily: mainFontFamily,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.02,
                  color: textPrimaryColor,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Container(
                height: size.height * 0.06,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  cursorColor: whiteColor1,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => _search(),
                  style: const TextStyle(
                    color: textPrimaryColor,
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
                    filled: true,
                    hintText: "Search Games",
                    hintStyle: const TextStyle(
                      color: textPrimaryColor,
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _search();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: textPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: games.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                  itemBuilder: (context, index) {
                    return SelectGameTile(
                      shortGameModel: games[index],
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SubmitButton(
                  buttonTitle: 'Done',
                  height: size.height * 0.05,
                  width: size.width * 0.25,
                  borderRadius: 10,
                  fontSize: 14,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
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
    searchController.dispose();
    super.dispose();
  }

  _search() async {
    setState(() => loading = true);

    try {
      await Future.wait([
        _restService
            .searchGames(
          query: searchController.text,
          page: 0,
          limit: 10,
        )
            .then((res) {
          setState(() => games = res.results);
          keyword = res.keyword;
          keywordHash = res.keywordHash;
        }),
      ]);
    } on DioError catch (e) {
      print('***** Exeption error: $e *****');
    } finally {
      setState(() => loading = false);
    }
  }
}

class SelectGameTile extends StatefulWidget {
  final ShortGameModel shortGameModel;

  const SelectGameTile({
    super.key,
    required this.shortGameModel,
  });

  @override
  State<SelectGameTile> createState() => _SelectGameTileState();
}

class _SelectGameTileState extends State<SelectGameTile> {
  RestService restService = Modular.get<RestService>();
  AuthService authService = Modular.get<AuthService>();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var oneplayId = widget.shortGameModel.oneplayId;
    var imageUrl = widget.shortGameModel.textBgImage.toString();
    var title = widget.shortGameModel.title.toString();
    var status = widget.shortGameModel.status.toString();

    return Stack(
      children: [
        InkWell(
          // focusNode: focusNode,
          // onTap: () {},
          child: Container(
            height: size.height * 1 / 7,
            width: size.width * 2.3 / 4.5,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  status == "live"
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.5),
                  BlendMode.srcOver,
                ),
                child: CachedNetworkImage(
                  height: size.height * 1 / 7,
                  width: size.width * 2.3 / 4.5,
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Stack(
                      children: [
                        Image.asset(
                          defaultBg,
                          fit: BoxFit.cover,
                          width: size.width * 2.3 / 4.5,
                        ),
                        Positioned(
                          top: 40,
                          left: 5,
                          child: Text(
                            title,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: mainFontFamily,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: size.height * 0.065,
          right: size.width * 0.06,
          child: Center(
            child: InkWell(
              onTap: () {
                if (isChecked == true) {
                  setState(() {
                    isChecked = !isChecked;
                    _removeFromWishlist(oneplayId);
                  });
                } else {
                  setState(() {
                    isChecked = !isChecked;
                    _addToWishlist(oneplayId);
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? blueColor1 : textPrimaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: isChecked
                      ? const Icon(
                          Icons.check,
                          size: 18.0,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.check_box_outline_blank,
                          size: 18.0,
                          color: textPrimaryColor,
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addToWishlist(String oneplayId) async {
    try {
      await restService.addToWishlist(oneplayId);
      authService.addToWishlist(oneplayId);
    } on DioError catch (e) {
      _showError(title: 'Error', message: e.error['message']);
    }
  }

  void _removeFromWishlist(String oneplayId) async {
    try {
      await restService.removeFromWishlist(oneplayId);
      authService.removeFromWishlist(oneplayId);
    } on DioError catch (e) {
      _showError(title: 'Error', message: e.error['message']);
    }
  }

  void _showError({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FocusZoom(
            builder: (focus) {
              return TextButton(
                focusNode: focus,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              );
            },
          ),
        ],
      ),
    );
  }
}
