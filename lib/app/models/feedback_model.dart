class FeedbackModel {
  String? gameId;
  String? userId;
  String? ip;
  String? userAgent;
  String? sessionId;
  FeedbackData? feedbackData;
  String? timestamp;
  String? sId;
  int? iV;

  FeedbackModel({
    this.gameId,
    this.userId,
    this.ip,
    this.userAgent,
    this.sessionId,
    this.feedbackData,
    this.timestamp,
    this.sId,
    this.iV,
  });

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    userId = json['user_id'];
    ip = json['ip'];
    userAgent = json['user_agent'];
    sessionId = json['session_id'];
    feedbackData = json['feedback_data'] != null
        ? FeedbackData.fromJson(json['feedback_data'])
        : null;
    timestamp = json['timestamp'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_id'] = gameId;
    data['user_id'] = userId;
    data['ip'] = ip;
    data['user_agent'] = userAgent;
    data['session_id'] = sessionId;
    if (feedbackData != null) {
      data['feedback_data'] = feedbackData!.toJson();
    }
    data['timestamp'] = timestamp;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

class FeedbackData {
  int? rating;
  String? suggestion;
  String? comment;
  List<Qna>? qna;

  FeedbackData({
    this.rating,
    this.suggestion,
    this.comment,
    this.qna,
  });

  FeedbackData.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    suggestion = json['suggestion'];
    comment = json['comment'];
    if (json['qna'] != null) {
      qna = <Qna>[];
      json['qna'].forEach((v) {
        qna!.add(Qna.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['suggestion'] = suggestion;
    data['comment'] = comment;
    if (qna != null) {
      data['qna'] = qna!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Qna {
  String? question;
  String? answer;

  Qna({
    this.question,
    this.answer,
  });

  Qna.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
