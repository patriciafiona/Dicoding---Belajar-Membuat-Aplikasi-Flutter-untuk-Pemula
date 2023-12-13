import 'package:flutter/material.dart';

import '../../../../data/local/model/Finance.dart';
import '../../../../data/local/sqlite_service.dart';
import '../../../widget/NoDataAnimation.dart';
import '../../../widget/TransactionWithEditItem.dart';

class WalletTabScreen extends StatefulWidget {
  const WalletTabScreen({super.key});

  @override
  State<WalletTabScreen> createState() => _WalletTabScreenState();
}

class _WalletTabScreenState extends State<WalletTabScreen> {

  List<Finance> transactionList = [];

  refresh() {
    setState(() {
      SqliteService.getFinanceHistory().then((data) {
        setState(() {
          transactionList = data;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    //Get transaction history
    SqliteService.getFinanceHistory().then((data) {
      setState(() {
        transactionList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transaction History",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800
            ),
          ),
          Container(
            width: double.infinity,
            height: 600,
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: transactionList.isNotEmpty ?
            TransactionList(data: transactionList, notifyParent: refresh) : const NoDataAnimation(width: 250, height: 250, textColor: Colors.white),
          ),
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.data, required this.notifyParent,
  });

  final List<Finance> data;
  final Function() notifyParent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return TransactionWithEditItem(data: item, notifyParent: notifyParent);
      },
    );
  }
}
