class User{
  final String name;
  final String cardNumber;
  final String joinDate;
  final String avatarString;

  User({
    required this.name,
    required this.cardNumber,
    required this.joinDate,
    required this.avatarString
  });

  User.fromMap(Map<String, dynamic> item):
        name = item["name"],
        cardNumber = item["cardNumber"],
        joinDate = item["joinDate"],
        avatarString = item["avatarString"];

  Map<String, Object> toMap(){
    return {
      'name':name,
      'cardNumber':cardNumber,
      'joinDate': joinDate,
      'avatarString': avatarString
    };
  }
}