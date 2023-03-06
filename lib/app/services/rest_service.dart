// ignore_for_file: avoid_print

import 'dart:io';

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

import '../models/device_history_model.dart';
import '../models/feedback_model.dart';
import '../models/ip_location_model.dart';
import '../models/signup_model.dart';
import '../models/subscription_model.dart';

class RestService {
  final Dio _dio;

  RestService(final AuthService authService)
      : _dio = Dio(
          BaseOptions(
            baseUrl: API_BASE_URL,
            connectTimeout: 30000,
            receiveTimeout: 30000,
          ),
        )..interceptors.add(
            AuthInterceptor(authService),
          );

  Future<UserModel> getProfile() async {
    Response userData = await _dio.get('/accounts/profile');

    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }

  Future<UserModel> updateProfileImage({
    required File imageFile,
  }) async {
    String fileName = imageFile.path.split('/').last;

    FormData data = FormData.fromMap({
      "profile_image": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    Response userData = await _dio.put('/accounts/profile', data: data);

    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }

  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    String? phone,
    String? userName,
    String? age,
  }) async {
    Response userData = await _dio.put('/accounts/profile', data: {
      'first_name': firstName,
      'last_name': lastName,
      'bio': bio,
      'phone': phone,
      'username': userName,
      'age': age,
    });

    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }

  Future<String> updatePassword({
    required String updatePassword,
  }) async {
    Response userPassword = await _dio.put('/accounts/password', data: {
      'password': updatePassword,
    });

    return userPassword.data['data'];
  }

  Future<String> forgotPassword({
    required String email,
  }) async {
    Response response =
        await _dio.post('/accounts/request_reset_password/$email');

    return response.data['data'];
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

  Future<List<ShortGameModel>> getGames(
      {String? releaseDate,
      int? playTime,
      bool? isFree,
      String? stores,
      String? developer,
      String? genres,
      String? publisher,
      int? limit}) async {
    final body = {
      if (releaseDate != null) 'release_date': releaseDate,
      if (playTime != null) 'play_time': playTime,
      if (isFree != null) 'is_free': isFree,
      if (stores != null) 'stores': stores,
      if (developer != null) 'developer': developer,
      if (genres != null) 'genres': genres,
      if (publisher != null) 'publisher': publisher,
      'order_by': "release_date:desc"
    };
    final params = {if (limit != null) 'limit': limit};

    Response res = await _dio.post('/games/feed/custom',
        data: body, queryParameters: params);

    var data = (res.data as List<dynamic>)
        .map((e) => ShortGameModel.fromJson(e))
        .toList();
    return data;
  }

  Future<List<String>> getTopGenres(int limit) async {
    final params = {'limit': limit};

    Response res = await _dio.get('/games/top_genres', queryParameters: params);

    var data = (res.data as List<dynamic>).map((e) => e.toString()).toList();
    return data;
  }

  Future<List<String>> getTopDevelopers(int limit) async {
    final params = {'limit': limit};

    Response res =
        await _dio.get('/games/top_developers', queryParameters: params);

    var data = (res.data as List<dynamic>).map((e) => e.toString()).toList();
    return data;
  }

  Future<List<String>> getTopPublishers(int limit) async {
    final params = {'limit': limit};

    Response res =
        await _dio.get('/games/top_publishers', queryParameters: params);

    var data = (res.data as List<dynamic>).map((e) => e.toString()).toList();
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

  Future<List<DeviceHistoryModel>> getDeviceHistory() async {
    Response res = await _dio.get('/accounts/sessions', queryParameters: {});

    var data = (res.data as List<dynamic>)
        .map((e) => DeviceHistoryModel.fromJson(e))
        .toList();

    return data;
  }

  Future<IPLocationModel> getLocation({required String ip}) async {
    Response res = await _dio.get('/location/$ip');

    var data = IPLocationModel.fromJson(res.data);

    return data;
  }

  Future<List<SubscriptionModel>> getCurrentSubscription() async {
    Response res = await _dio.get('/accounts/subscription/current');

    var data = (res.data as List<dynamic>)
        .map((e) => SubscriptionModel.fromJson(e))
        .toList();

    return data;
  }

  Future<List<SubscriptionModel>> getSubscriptionHistory() async {
    Response res = await _dio.get('/accounts/subscription/all');

    var data = (res.data as List<dynamic>)
        .map((e) => SubscriptionModel.fromJson(e))
        .toList();

    return data;
  }

  Future<bool> logoutFromDevice(String userKey) async {
    Response res = await _dio.delete("/accounts/sessions/$userKey");
    return res.data['success'];
  }

  Future<FeedbackModel> feedBack({
    required String gameId,
    required String userId,
    required String sessionId,
    required int rating,
    required String suggestion,
    required String comment,
    required String question,
    required String answer,
    required String question2,
    required String answer2,
  }) async {
    Response response = await _dio.post('/logging/feedback', data: {
      "game_id": gameId,
      "user_id": userId,
      "session_id": sessionId,
      "rating": rating,
      "suggestion": suggestion,
      "comment": comment,
      "qna": [
        {
          "question": question,
          "answer": answer,
        },
        {
          "question": question2,
          "answer": answer2,
        },
      ]
    });

    var data = FeedbackModel.fromJson(response.data);

    return data;
  }

  Future<void> postAReport(String? message, dynamic response) async {
    await _dio.post('/logging/report', data: {
      "message": message,
      "response": response,
    });
  }

  Future<bool> setSearchPrivacy({required bool isPrivacy}) async {
    Response response = await _dio.put('/accounts/set_search_privacy', data: {
      "search_privacy": isPrivacy,
    });

    return response.data['success'];
  }
}
