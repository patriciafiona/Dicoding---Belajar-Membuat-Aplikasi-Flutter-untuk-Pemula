import 'package:financial_app/ui/screen/AddDataScreen/AddDataScreen.dart';
import 'package:financial_app/ui/widget/RoundedButtonWithText.dart';
import 'package:financial_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import '../../../../utils/CustomColors.dart';
import '../../../widget/TextWithIcon.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
                Text(
                  "\$0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 8,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: purplishBlue,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButtonWithText(
                          title: "Income",
                          icon: Icons.arrow_upward,
                          textColor: Colors.white,
                          buttonColor: Colors.white,
                          iconColor: purpleHoneycreeper,
                          onPressAction: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const AddDataScreen(type: "income");
                            }));
                          }
                      ),
                      RoundedButtonWithText(
                          title: "Outcome",
                          icon: Icons.arrow_downward,
                          textColor: Colors.white,
                          buttonColor: Colors.white,
                          iconColor: purpleHoneycreeper,
                          onPressAction: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const AddDataScreen(type: "outcome");
                            }));
                          }
                      ),
                      RoundedButtonWithText(
                          title: "My Card",
                          icon: Icons.credit_card,
                          textColor: Colors.white,
                          buttonColor: Colors.white,
                          iconColor: purpleHoneycreeper,
                          onPressAction: () {}
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: TextWithIcon(
                        icon: Icons.graphic_eq,
                        iconColor: Colors.white,
                        text: "Tracker",
                        textSize: 18,
                        textColor: Colors.white
                    )
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Month",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12
                      ),
                    ),
                  ),
                  Text(
                    returnCurrentMonth(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
