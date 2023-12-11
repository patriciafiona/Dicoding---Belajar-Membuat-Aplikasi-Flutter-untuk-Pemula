import 'package:flutter/material.dart';

import '../../../utils/CustomColors.dart';
import '../../widget/TextWithIcon.dart';

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({super.key});

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
                                "PATRICIA FIONA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "OCR-A"
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "11/28",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "OCR-A"
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "1234 5678 9012 3456",
                            style: TextStyle(
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
            Spacer(),
            Expanded(
            flex: 9,
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
                    padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWithIcon(
                            icon: Icons.balance,
                            iconColor: Colors.white,
                            text: "Total Balance",
                            textSize: 20,
                            textColor: Colors.white
                        ),
                        Text(
                          "\$0",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Income: ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "+ \$0.00",
                              style: TextStyle(
                                  color: Colors.lightGreenAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(width: 32),
                            Text(
                              "Outcome: ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "+ \$0.00",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [

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
