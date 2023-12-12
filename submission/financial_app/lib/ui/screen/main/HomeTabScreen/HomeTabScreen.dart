import 'dart:math';

import 'package:financial_app/ui/screen/AddDataScreen/AddDataScreen.dart';
import 'package:financial_app/ui/screen/cardDetail/CardDetailScreen.dart';
import 'package:financial_app/ui/widget/RoundedButtonWithText.dart';
import 'package:financial_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../utils/CurrencyFormat.dart';
import '../../../../utils/CustomColors.dart';
import '../../../widget/TextWithIcon.dart';

class HomeTabScreen extends StatefulWidget {
  HomeTabScreen({super.key});

  final Color barBackgroundColor = Colors.white54;
  final Color barColor = californiaGirl;
  final Color touchedBarColor = iceColdStare;

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {

  double currentBalance = 0.0;
  double incomeSum = 0.0;
  double outcomeSum = 0.0;

  //Bar chart settings
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    //Get current balance
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    ),
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(currentBalance, 2),
                    style: const TextStyle(
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
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      child: const AddDataScreen(type: "income")
                                  )
                              );
                            }
                        ),
                        RoundedButtonWithText(
                            title: "Outcome",
                            icon: Icons.arrow_downward,
                            textColor: Colors.white,
                            buttonColor: Colors.white,
                            iconColor: purpleHoneycreeper,
                            onPressAction: () {
                              Navigator.push(
                                context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      child: const AddDataScreen(type: "outcome")
                                  )
                              );
                            }
                        ),
                        RoundedButtonWithText(
                            title: "My Card",
                            icon: Icons.credit_card,
                            textColor: Colors.white,
                            buttonColor: Colors.white,
                            iconColor: purpleHoneycreeper,
                            onPressAction: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      child: const CardDetailScreen()
                                  )
                              );
                            }
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                        child: BarChart(
                          mainBarData(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 50,
        List<int> showTooltips = const [],
      }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.white12)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: incomeSum > outcomeSum ? (incomeSum/1000) : (outcomeSum/1000), //set max of the bar value
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(2, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, incomeSum/1000, isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, outcomeSum/1000, isTouched: i == touchedIndex);
      default:
        return throw Error();
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String type;
            switch (group.x) {
              case 0:
                type = 'Income';
                break;
              case 1:
                type = 'Outcome';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$type\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "${(rod.toY - 1).toString()}k",
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Income', style: style);
        break;
      case 1:
        text = const Text('Outcome', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
