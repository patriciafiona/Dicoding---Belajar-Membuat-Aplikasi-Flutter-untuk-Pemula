import 'package:financial_app/data/local/sqlite_service.dart';
import 'package:financial_app/ui/screen/changeData/ChangeDataScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../data/local/model/Finance.dart';
import '../../utils/CurrencyFormat.dart';
import '../../utils/CustomColors.dart';

class TransactionWithEditItem extends StatelessWidget {
  final Function() notifyParent;
  final Finance data;

  const TransactionWithEditItem({super.key, required this.data, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    var tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(data.dateTime);
    var transactionDate = DateFormat.yMMMMd().format(tempDate).toString();

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ChangeDataScreen(selectedData: data)
                )
            );
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            //remove from database
            SqliteService.deleteTransaction(data.id);
            notifyParent();
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white
          ),
          padding: const EdgeInsets.all(16),
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
                  padding: const EdgeInsets.only(left: 12),
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
                        "The transaction occurred on $transactionDate",
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
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${data.category == "income" ? "" : "- "}${CurrencyFormat.convertToIdr(data.amount, 2)}",
                    style: TextStyle(
                        color: data.category == "income" ? purplishBlue : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
