class SubscriptionModel {
  String? id;
  int? amount;
  int? broughtPrice;
  String? wasFreePlan;
  String? wasOffer;
  Null? offerId;
  String? refer;
  Null? referSource;
  int? subscribedDurationInDays;
  String? subscriptionBroughtAtTime;
  String? subscriptionActiveFrom;
  String? subscriptionActiveTill;
  String? subscriptionStatus;
  SubscriptionPackage? subscriptionPackage;
  Payment? payment;

  SubscriptionModel({
    this.id,
    this.amount,
    this.broughtPrice,
    this.wasFreePlan,
    this.wasOffer,
    this.offerId,
    this.refer,
    this.referSource,
    this.subscribedDurationInDays,
    this.subscriptionBroughtAtTime,
    this.subscriptionActiveFrom,
    this.subscriptionActiveTill,
    this.subscriptionStatus,
    this.subscriptionPackage,
    this.payment,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    broughtPrice = json['brought_price'];
    wasFreePlan = json['was_free_plan'];
    wasOffer = json['was_offer'];
    offerId = json['offer_id'];
    refer = json['refer'];
    referSource = json['refer_source'];
    subscribedDurationInDays = json['subscribed_duration_in_days'];
    subscriptionBroughtAtTime = json['subscription_brought_at_time'];
    subscriptionActiveFrom = json['subscription_active_from'];
    subscriptionActiveTill = json['subscription_active_till'];
    subscriptionStatus = json['subscription_status'];
    subscriptionPackage = json['subscriptionPackage'] != null
        ? SubscriptionPackage.fromJson(json['subscriptionPackage'])
        : null;
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['brought_price'] = broughtPrice;
    data['was_free_plan'] = wasFreePlan;
    data['was_offer'] = wasOffer;
    data['offer_id'] = offerId;
    data['refer'] = refer;
    data['refer_source'] = referSource;
    data['subscribed_duration_in_days'] = subscribedDurationInDays;
    data['subscription_brought_at_time'] = subscriptionBroughtAtTime;
    data['subscription_active_from'] = subscriptionActiveFrom;
    data['subscription_active_till'] = subscriptionActiveTill;
    data['subscription_status'] = subscriptionStatus;
    if (subscriptionPackage != null) {
      data['subscriptionPackage'] = subscriptionPackage!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    return data;
  }
}

class SubscriptionPackage {
  String? id;
  int? createdAt;
  int? updatedAt;
  String? isFree;
  int? value;
  String? currency;
  String? isActive;
  String? planName;
  String? planDescription;
  String? canRun4k;
  String? canRunMobile;
  String? canRunHd;

  SubscriptionPackage({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isFree,
    this.value,
    this.currency,
    this.isActive,
    this.planName,
    this.planDescription,
    this.canRun4k,
    this.canRunMobile,
    this.canRunHd,
  });

  SubscriptionPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFree = json['is_free'];
    value = json['value'];
    currency = json['currency'];
    isActive = json['is_active'];
    planName = json['plan_name'];
    planDescription = json['plan_description'];
    canRun4k = json['can_run_4k'];
    canRunMobile = json['can_run_mobile'];
    canRunHd = json['can_run_hd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_free'] = isFree;
    data['value'] = value;
    data['currency'] = currency;
    data['is_active'] = isActive;
    data['plan_name'] = planName;
    data['plan_description'] = planDescription;
    data['can_run_4k'] = canRun4k;
    data['can_run_mobile'] = canRunMobile;
    data['can_run_hd'] = canRunHd;
    return data;
  }
}

class Payment {
  String? id;
  String? status;
  String? userIp;
  String? userDevice;
  String? deviceAgent;
  String? createdAt;
  String? updatedAt;

  Payment({
    this.id,
    this.status,
    this.userIp,
    this.userDevice,
    this.deviceAgent,
    this.createdAt,
    this.updatedAt,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userIp = json['user_ip'];
    userDevice = json['user_device'];
    deviceAgent = json['device_agent'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['user_ip'] = userIp;
    data['user_device'] = userDevice;
    data['device_agent'] = deviceAgent;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
