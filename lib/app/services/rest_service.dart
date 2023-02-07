// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/interceptors/auth_interceptor.dart';
import 'package:oneplay_flutter_gui/app/models/friend_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_feed_model.dart';
import 'package:oneplay_flutter_gui/app/models/game_model.dart';
import 'package:oneplay_flutter_gui/app/models/search_model.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/models/video_model.dart';
import 'package:oneplay_flutter_gui/app/services/auth_service.dart';

import '../models/signup_model.dart';

class RestService {
  final Dio _dio;

  RestService(final AuthService authService)
      : _dio = Dio(
          BaseOptions(
            baseUrl: API_BASE_URL,
            connectTimeout: 30000,
            receiveTimeout: 30000,
          ),
        )..interceptors.add(AuthInterceptor(authService));

  Future<UserModel> getProfile() async {
    Response userData = await _dio.get('/accounts/profile');

    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }

  Future<SignupModel> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String gender,
    required String password,
    required String refferedId,
  }) async {
    print('***** Email: $email *****');
    print('***** First name: $firstName *****');
    print('***** Last name: $lastName *****');
    print('***** Phone: $phone *****');
    print('***** Gender: $gender *****');
    print('***** Password: $password *****');
    print('***** Reffered id: $refferedId *****');
    print('***** PARTNER_ID: $PARTNER_ID *****');

    Response signUpData = await _dio.post('/accounts/signup', data: {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'gender': gender,
      'password': password,
      'device': 'mobile',
      'referred_by_id': refferedId,
      'partnerId': PARTNER_ID,
    });

    print('***** Signup response: $signUpData *****');

    final myMap = Map<String, dynamic>.from(signUpData.data);
    return SignupModel.fromJson(myMap);
  }

  Future<String> login({
    required String id,
    required String password,
  }) async {
    Response loginData = await _dio.post(
      '/accounts/login',
      data: {
        'id': id,
        'password': password,
        'device': 'mobile',
      },
    );

    return loginData.data['session_token'];
  }

  Future<List<String>> getWishlist() async {
    Response res = await _dio.get('/accounts/wishlist');

    return (res.data as List<dynamic>).map((e) => e as String).toList();
  }

  Future<GameModel> getGameDetails(String id) async {
    Response res = await _dio.get('/games/$id/info');

    return GameModel.fromJson(res.data);
  }

  Future<List<GameFeedModel>> getHomeFeed() async {
    Response res = await _dio.get('/games/feed/personalized', queryParameters: {
      'textBackground': "280x170",
      'textLogo': "400x320",
      'poster': "528x704",
    });

    var data = (res.data as List<dynamic>)
        .map((d) => GameFeedModel.fromJson(d))
        .toList();

    return data;
  }

  Future<SearchGamesModel> searchGames({
    required String query,
    required int page,
    required int limit,
    String? status,
  }) async {
    final params = {
      "query": query,
      "page": page,
      "limit": limit,
    };

    if (status != null) {
      params["status"] = status;
    }

    Response res = await _dio.get("/games/search", queryParameters: params);

    return SearchGamesModel.fromJson(res.data);
  }

  Future<List<ShortUserModel>> searchUsers({
    required String query,
    required int page,
    required int limit,
  }) async {
    Response res = await _dio.get('/accounts/search/', queryParameters: {
      "query": query,
      "page": page,
      "limit": limit,
    });

    var data = (res.data as List<dynamic>)
        .map((e) => ShortUserModel.fromJson(e))
        .toList();

    return data;
  }

  Future<List<FriendModel>> getAllFriends() async {
    Response res = await _dio.get('/social/friends/all');

    var data = (res.data as List<dynamic>)
        .map((e) => FriendModel.fromJson(e))
        .toList();

    return data;
  }

  Future<List<FriendModel>> getPendingSentRequests() async {
    Response res = await _dio.get('/social/friends/pending_sent_requests');

    var data = (res.data as List<dynamic>)
        .map((e) => FriendModel.fromJson(e))
        .toList();

    return data;
  }

  Future<List<FriendModel>> getPendingReceivedRequests() async {
    Response res = await _dio.get('/social/friends/pending_received_requests');

    var data = (res.data as List<dynamic>)
        .map((e) => FriendModel.fromJson(e))
        .toList();

    return data;
  }

  Future<String> addFriend(String id) async {
    Response res = await _dio.post("/social/friends/$id/send_request");

    return res.data["id"];
  }

  Future<void> acceptFriend(String id) async {
    await _dio.put("/social/friends/$id/accept_request");
  }

  Future<void> deleteFriend(String id) async {
    await _dio.delete("/social/friends/$id");
  }

  Future<void> getStreamsFeed() async {
    await _dio.get('/streams');
  }

  Future<List<VideoModel>> getVideos(String id) async {
    Response res = await _dio.get('/streams/$id');

    var data =
        (res.data as List<dynamic>).map((e) => VideoModel.fromJson(e)).toList();

    return data;
  }

  Future<List<ShortGameModel>> getGamesByGenre(String genre) async {
    final body = {'genres': genre, 'order_by': "trend_score:desc"};

    Response res = await _dio.post('/games/feed/custom', data: body);

    var data = (res.data as List<dynamic>)
        .map((e) => ShortGameModel.fromJson(e))
        .toList();
    return data;
  }

  Future<List<ShortGameModel>> getGamesByDeveloper(String developer) async {
    final body = {'developer': developer, 'order_by': "trend_score:desc"};

    Response res = await _dio.post('/games/feed/custom', data: body);

    var data = (res.data as List<dynamic>)
        .map((e) => ShortGameModel.fromJson(e))
        .toList();
    return data;
  }

  Future<void> addToWishlist(String gameId) async {
    await _dio.post("/accounts/add_to_wishlist/$gameId");
  }

  Future<void> removeFromWishlist(String gameId) async {
    await _dio.post("/accounts/remove_from_wishlist/$gameId");
  }

  Future<List<ShortGameModel>> getWishlistGames(List<String> gameIds) async {
    Response res = await _dio.post('/games/feed/custom', data: {
      "content_ids": gameIds.join(','),
    });

    return (res.data as List<dynamic>)
        .map((e) => ShortGameModel.fromJson(e))
        .toList();
  }
}
