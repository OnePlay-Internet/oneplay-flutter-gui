class DeviceHistoryModel {
  String? userId;
  String? partnerId;
  String? device;
  String? ip;
  String? uagent;
  String? timestamp;
  String? key;

  DeviceHistoryModel({
    this.userId,
    this.partnerId,
    this.device,
    this.ip,
    this.uagent,
    this.timestamp,
    this.key,
  });

  DeviceHistoryModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    partnerId = json['partnerId'];
    device = json['device'];
    ip = json['ip'];
    uagent = json['uagent'];
    timestamp = json['timestamp'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['partnerId'] = partnerId;
    data['device'] = device;
    data['ip'] = ip;
    data['uagent'] = uagent;
    data['timestamp'] = timestamp;
    data['key'] = key;
    return data;
  }
}
