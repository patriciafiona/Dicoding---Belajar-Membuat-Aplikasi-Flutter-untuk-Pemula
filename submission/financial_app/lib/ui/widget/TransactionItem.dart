import 'package:flutter/material.dart';

import '../../data/local/model/Finance.dart';
import '../../utils/CurrencyFormat.dart';
import '../../utils/CustomColors.dart';

class TransactionItem extends StatelessWidget {
  final Finance data;

  const TransactionItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: data.category == "income" ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3)
              ),
              child: Center(
                child: Icon(
                  data.category == "income" ? Icons.arrow_upward : Icons.arrow_downward,
                  color: data.category == "income" ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    data.category,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${data.category == "income" ? "" : "- "}${CurrencyFormat.convertToIdr(data.amount, 2)}",
                style: TextStyle(
                    color: data.category == "income" ? purplishBlue : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
