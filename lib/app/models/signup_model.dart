class SignupModel {
  String? msg;
  bool? isSignupSuccessfull;

  SignupModel({this.msg, this.isSignupSuccessfull});

  SignupModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    isSignupSuccessfull = json['is_signup_successfull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['is_signup_successfull'] = isSignupSuccessfull;
    return data;
  }
}
