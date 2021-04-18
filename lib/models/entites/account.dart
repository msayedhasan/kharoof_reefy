import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Account({
    this.customerId,
    this.customerGroupId,
    this.storeId,
    this.languageId,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.fax,
    this.cart,
    this.wishlist,
    this.newsletter,
    this.addressId,
    this.ip,
    this.status,
    this.safe,
    this.token,
    this.code,
    this.dateAdded,
    this.otp,
    this.mobileVerified,
    this.accountCustomField,
    this.rewardTotal,
    this.rewards,
    this.userBalance,
  });

  String customerId;
  String customerGroupId;
  String storeId;
  String languageId;
  String firstname;
  String lastname;
  String email;
  String telephone;
  String fax;
  dynamic cart;
  dynamic wishlist;
  String newsletter;
  String addressId;
  String ip;
  String status;
  String safe;
  String token;
  String code;
  DateTime dateAdded;
  dynamic otp;
  String mobileVerified;
  dynamic accountCustomField;
  String rewardTotal;
  List<Reward> rewards;
  String userBalance;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        customerId: json["customer_id"],
        customerGroupId: json["customer_group_id"],
        storeId: json["store_id"],
        languageId: json["language_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"] ?? '',
        fax: json["fax"],
        cart: json["cart"],
        wishlist: json["wishlist"],
        newsletter: json["newsletter"],
        addressId: json["address_id"],
        ip: json["ip"],
        status: json["status"],
        safe: json["safe"],
        token: json["token"],
        code: json["code"],
        dateAdded: DateTime.parse(json["date_added"]),
        otp: json["otp"],
        mobileVerified: json["mobile_verified"],
        accountCustomField: json["account_custom_field"],
        rewardTotal: json["reward_total"],
        rewards: json["rewards"] != null
            ? List<Reward>.from(json["rewards"].map((x) => Reward.fromJson(x)))
            : [],
        userBalance: json["user_balance"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_group_id": customerGroupId,
        "store_id": storeId,
        "language_id": languageId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "telephone": telephone,
        "fax": fax,
        "cart": cart,
        "wishlist": wishlist,
        "newsletter": newsletter,
        "address_id": addressId,
        "ip": ip,
        "status": status,
        "safe": safe,
        "token": token,
        "code": code,
        "date_added": dateAdded.toIso8601String(),
        "otp": otp,
        "mobile_verified": mobileVerified,
        "account_custom_field": accountCustomField,
        "reward_total": rewardTotal,
        "rewards": List<dynamic>.from(rewards.map((x) => x.toJson())),
        "user_balance": userBalance,
      };
}

class Reward {
  Reward({
    this.orderId,
    this.points,
    this.description,
    this.dateAdded,
  });

  String orderId;
  String points;
  String description;
  String dateAdded;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        orderId: json["order_id"],
        points: json["points"],
        description: json["description"],
        dateAdded: json["date_added"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "points": points,
        "description": description,
        "date_added": dateAdded,
      };
}
