import 'dart:ffi';

import 'package:financial_app/data/local/model/Finance.dart';
import 'package:financial_app/ui/screen/main/MainScreen.dart';
import 'package:financial_app/ui/widget/LottieAnimation.dart';
import 'package:financial_app/ui/widget/TextWithIcon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../data/local/sqlite_service.dart';
import '../../../utils/CurrencyInputFormatter.dart';
import '../../../utils/CustomColors.dart';

class AddDataScreen extends StatefulWidget {
  final String type;

  const AddDataScreen({super.key, required this.type});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  //Set loading
  bool isLoading = false;
  set Bool(bool status) => setState(() => isLoading = status);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purplishBlue,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Add Data',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: isLoading ? LoadingContainer() : MainContent(context: context, type: widget.type, callback: (val) => setState(() => isLoading = val))
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: purpleHoneycreeper,
      child: const Center(
        child: LottieAnimation(
          animationName: 'app_logo_animation',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

typedef void BoolCallback(bool val);

class MainContent extends StatefulWidget {
  final BuildContext context;
  final String type;
  final BoolCallback callback;

  const MainContent({super.key, required this.type, required this.callback, required this.context});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  //Selected date
  String _selectedDate = DateTime.now().toString();

  //Selected type dropdown
  late String _selectedTypeValue;

  //Controller for amount and description
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  //set dropdown option
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "income", child: Text("Income")),
      const DropdownMenuItem(value: "outcome", child: Text("Outcome")),
    ];
    return menuItems;
  }

  @override
  void initState() {
    super.initState();
    _selectedTypeValue = widget.type;
    if (kDebugMode) {
      print("INITIAL SELECTED DATE: $_selectedDate");
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        if (kDebugMode) {
          print("SELECTED DATE: $_selectedDate");
        }
      }
    });
  }

  //Set currency type
  static const _locale = 'id';
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: purpleHoneycreeper,
          child: Image.asset(
            "assets/image/pattern_01.png",
            width: double.infinity,
            height: 250,
            repeat: ImageRepeat.repeat,
            opacity: const AlwaysStoppedAnimation(.2),
          ),
        ),
        Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Finance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Add new ${widget.type} data',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: TextWithIcon(
                                icon: Icons.money_rounded,
                                iconColor: purplishBlue,
                                text: "Amount",
                                textSize: 16,
                                textColor: purplishBlue
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyInputFormatter(),
                            ],
                            style: TextStyle(
                                color: purplishBlue
                            ),
                            decoration: InputDecoration(
                              prefixText: _currency,
                              fillColor: Colors.white60,
                              filled: true,
                              border: const OutlineInputBorder(),
                              enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: cloudBreak, width: 1.0),
                              ),
                              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: iceColdStare, width: 1.0),
                              ),
                              hintText: 'Enter amount here...',
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextWithIcon(
                                icon: Icons.category,
                                iconColor: purplishBlue,
                                text: "Type",
                                textSize: 16,
                                textColor: purplishBlue
                            )
                        ),
                        DropdownButton(
                          isExpanded: true,
                          value: _selectedTypeValue,
                          items: dropdownItems,
                          onChanged: null,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextWithIcon(
                                icon: Icons.edit,
                                iconColor: purplishBlue,
                                text: "Date",
                                textSize: 16,
                                textColor: purplishBlue
                            )
                        ),
                        SfDateRangePicker(
                          onSelectionChanged: _onSelectionChanged,
                          view: DateRangePickerView.month,
                          selectionMode: DateRangePickerSelectionMode.single,
                          initialSelectedDate: DateTime.now(),
                          maxDate: DateTime.now(),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextWithIcon(
                                icon: Icons.edit,
                                iconColor: purplishBlue,
                                text: "Description",
                                textSize: 16,
                                textColor: purplishBlue
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                          child: TextField(
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(
                                color: purplishBlue
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white, filled: true,
                              border: const OutlineInputBorder(),
                              enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: cloudBreak, width: 1.0),
                              ),
                              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: iceColdStare, width: 1.0),
                              ),
                              hintText: 'Enter description here...',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 32),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                //show loading
                                widget.callback(true);

                                //set data
                                var data = Finance(
                                    id: 0,
                                    amount: double.parse(amountController.text.replaceAll(",", "")),
                                    category: _selectedTypeValue,
                                    description: descriptionController.text,
                                    dateTime: _selectedDate
                                );

                                //insert to database
                                await SqliteService.insertToDatabase(data);

                                //Go to Home screen
                                await Future.delayed(const Duration(milliseconds: 1500));
                                widget.callback(false);
                                await Navigator.push(
                                    widget.context,
                                    PageTransition(type: PageTransitionType.fade, child: MainScreen())
                                );
                              },
                              child: const Text('Submit'),
                            ),
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
      ],
    );
  }
}


