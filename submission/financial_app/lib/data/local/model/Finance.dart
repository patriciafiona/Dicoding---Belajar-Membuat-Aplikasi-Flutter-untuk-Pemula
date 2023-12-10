class Finance{
  final int id;
  final double amount;
  final String category;
  final String description;
  final String dateTime;

  Finance({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.dateTime
  });

  Finance.fromMap(Map<String, dynamic> item):
        id = item["id"],
        amount = item["amount"],
        category = item["category"],
        description = item["description"],
        dateTime = item["dateTime"];

  Map<String, Object> toMap(){
    return {
      'amount':amount,
      'category':category,
      'description': description,
      'dateTime': dateTime
    };
  }
}