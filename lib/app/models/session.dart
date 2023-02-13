class Sesstion {
  String? userId;
  String? device;
  String? ip;
  String? browser;
  String? os;
  String? key;
  String? timestamp;

  Sesstion({
    this.userId,
    this.device,
    this.ip,
    this.browser,
    this.os,
    this.key,
    this.timestamp,
  });

  Sesstion.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    device = json['device'];
    ip = json['ip'];
    browser = json['browser'];
    os = json['os'];
    key = json['key'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['device'] = device;
    data['ip'] = ip;
    data['browser'] = browser;
    data['os'] = os;
    data['key'] = key;
    data['timestamp'] = timestamp;
    return data;
  }
}
