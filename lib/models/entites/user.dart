class User {
  User({
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
  String userBalance;

  factory User.fromJson(Map<String, dynamic> json) =>
      User(telephone: json["telephone"]);

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
        "user_balance": userBalance,
      };
}
