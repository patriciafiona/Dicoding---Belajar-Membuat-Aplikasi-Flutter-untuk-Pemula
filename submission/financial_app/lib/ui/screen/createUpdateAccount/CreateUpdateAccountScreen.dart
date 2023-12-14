import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../data/local/model/User.dart';
import '../../../data/local/sqlite_service.dart';
import '../../../utils/CustomColors.dart';
import '../../widget/TextWithIcon.dart';
import '../main/MainScreen.dart';

class CreateUpdateAccountScreen extends StatefulWidget {
  final String action;
  const CreateUpdateAccountScreen({super.key, required this.action});

  @override
  State<CreateUpdateAccountScreen> createState() => _CreateUpdateAccountScreenState();
}

class _CreateUpdateAccountScreenState extends State<CreateUpdateAccountScreen> {
  //Set avatar name
  String avatarName = DateTime.now().toIso8601String();
  String userJoinDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  //Set random card number
  var cardNumber = "";

  var rnd = Random();
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  //Controller for text input
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cardNumber = getRandomString(16);

    if(widget.action == "update"){
      SqliteService.getUser().then((data) {
        setState(() {
          nameController.text = data.name;
          cardNumber = data.cardNumber;
          userJoinDate = data.joinDate;
          avatarName = data.avatarString;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/image/abstract_waterdrop.png",
                  width: double.infinity,
                  height: 250,
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 16, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: RandomAvatar(
                              avatarName,
                              height: 80,
                              width: 80
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 60,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  avatarName = DateTime.now().toIso8601String();
                                });
                              },
                              fillColor: californiaGirl,
                              padding: const EdgeInsets.all(2.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.refresh,
                                size: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.action == "create" ? "Create Account" : "Update Account",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: purpleHoneycreeper,
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const TextWithIcon(
                              icon: Icons.person,
                              iconColor: Colors.white,
                              text: "Full name",
                              textSize: 16,
                              textColor: Colors.white
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                            child: Column(
                              children: [
                                TextField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
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
                                    hintText: 'Enter your name here...',
                                  ),
                                ),
                                const SizedBox(height: 32),
                                ElevatedButton(
                                    onPressed: () async {
                                      if(widget.action == "update"){
                                        //set data
                                        var data = User(
                                            name: nameController.text,
                                            cardNumber: cardNumber.toString(),
                                            joinDate: userJoinDate,
                                            avatarString: avatarName

                                        );

                                        //insert to database
                                        await SqliteService.updateUserData(data);
                                      }else if(widget.action == "create"){
                                        //set data
                                        var data = User(
                                            name: nameController.text,
                                            cardNumber: cardNumber.toString(),
                                            joinDate: userJoinDate,
                                            avatarString: avatarName

                                        );

                                        //insert to database
                                        await SqliteService.insertUserToDatabase(data);
                                      }

                                      //Go to Home screen
                                      await Navigator.pushReplacement(
                                          context,
                                          PageTransition(type: PageTransitionType.fade, child: MainScreen())
                                      );
                                    },
                                    child: Text(widget.action == "create" ? "Create" : "Update")
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
