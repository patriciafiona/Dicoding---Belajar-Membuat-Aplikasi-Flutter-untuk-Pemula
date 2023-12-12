import 'package:intl/intl.dart';

import '../data/local/sqlite_service.dart';

String returnCurrentMonth() {
  var currentDateTime = DateTime.now();
  return DateFormat.MMMM().format(currentDateTime);
}

Future<double> getTotalIncomeThisMonth() async {
  var listData = await SqliteService.getFinanceItems();
  var totalIncome = 0.0;
  for (var i=0; i<listData.length; i++){
    var tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(listData[i].dateTime);
    if(tempDate.month == DateTime.now().month) {
      if (listData[i].category == "income") {
        totalIncome += listData[i].amount;
      }
    }
  }
  return totalIncome;
}

Future<double> getTotalOutcomeThisMonth() async {
  var listData = await SqliteService.getFinanceItems();
  var totalOutcome = 0.0;
  for (var i=0; i<listData.length; i++){
    var tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(listData[i].dateTime);
    if(tempDate.month == DateTime.now().month) {
      if (listData[i].category == "outcome") {
        totalOutcome += listData[i].amount;
      }
    }
  }
  return totalOutcome;
}

Future<double> getCurrentBalance() async {
  var listData = await SqliteService.getFinanceItems();
  var total = 0.0;
  for (var i=0; i<listData.length; i++){
    if(listData[i].category == "outcome"){
      total -= listData[i].amount;
    }else if(listData[i].category == "income"){
      total += listData[i].amount;
    }
  }
  return total;
}