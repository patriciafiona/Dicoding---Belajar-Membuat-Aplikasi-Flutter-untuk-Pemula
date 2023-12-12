import 'package:financial_app/ui/widget/TransactionItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/local/model/Finance.dart';
import '../../../data/local/sqlite_service.dart';
import '../../../utils/CurrencyFormat.dart';
import '../../../utils/CustomColors.dart';
import '../../../utils/Utils.dart';
import '../../widget/TextWithIcon.dart';

class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({super.key});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  String username = "Getting data...";
  String cardNumber = "Getting data...";
  String joinDate = "Getting data...";

  DateTime tempDate = DateTime.now();

  double currentBalance = 0.0;
  double incomeSum = 0.0;
  double outcomeSum = 0.0;
  List<Finance> lastThreeTransaction = [];

  @override
  void initState() {
    super.initState();
    SqliteService.getUser().then((user) {
      setState(() {
        username = user.name;
        var dataCardNum = user.cardNumber;
        cardNumber = "${dataCardNum.substring(0, 4)} "
            "${dataCardNum.substring(4, 8)} "
            "${dataCardNum.substring(8, 12)} "
            "${dataCardNum.substring(12, 16)}";

        tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(user.joinDate);
        joinDate = "${tempDate.month}/${tempDate.year}";
      });
    });

    getCurrentBalance().then((balance) {
      setState(() {
        currentBalance = balance;
      });
    });

    //Get current income
    getTotalIncomeThisMonth().then((income) {
      setState(() {
        incomeSum = income;
      });
    });

    //Get current outcome
    getTotalOutcomeThisMonth().then((outcome) {
      setState(() {
        outcomeSum = outcome;
      });
    });

    //Get last 3 transaction
    SqliteService.getLastThreeTransactionItems().then((data) {
      setState(() {
        lastThreeTransaction = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleHoneycreeper,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Card Details',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      backgroundColor: purpleHoneycreeper,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff870160),
                      Color(0xffac255e),
                      Color(0xffca485c),
                      Color(0xffe16b5c),
                      Color(0xfff39060),
                      Color(0xffffb56b),
                    ], // Gradient from https://learnui.design/tools/gradient-generator.html
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/image/abstract_line.png",
                      width: 300,
                      height: 200,
                      opacity: const AlwaysStoppedAnimation(.2),
                    ),
                    Container(
                      width: 300,
                      height: 200,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "My Card",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "OCR-A"
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "MEMBER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 5,
                                          fontFamily: "OCR-A"
                                      ),
                                    ),
                                    Text(
                                      "SINCE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 5,
                                          fontFamily: "OCR-A"
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  joinDate,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "OCR-A"
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            cardNumber,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "OCR-A"
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Expanded(
            flex: 10,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: purplishBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWithIcon(
                            icon: Icons.balance,
                            iconColor: Colors.white,
                            text: "Total Balance",
                            textSize: 16,
                            textColor: Colors.white
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(currentBalance, 2),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Detail income and outcome for ${returnCurrentMonth()}",
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Income: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                "+ ${CurrencyFormat.convertToIdr(incomeSum, 2)}",
                                style: const TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                "Outcome: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                "+ ${CurrencyFormat.convertToIdr(outcomeSum, 2)}",
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Last Transaction",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 170,
                              padding: const EdgeInsets.only(top: 8, bottom: 32),
                              child: ListView.builder(
                                itemCount: lastThreeTransaction.length,
                                itemBuilder: (context, index) {
                                  final item = lastThreeTransaction[index];
                                  return TransactionItem(data: item);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
