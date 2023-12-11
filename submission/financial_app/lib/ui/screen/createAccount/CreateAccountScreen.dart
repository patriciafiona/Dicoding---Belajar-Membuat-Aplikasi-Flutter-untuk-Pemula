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

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  //Set avatar name
  final String avatarName = DateTime.now().toIso8601String();

  //Set random card number
  var cardNumber = "";

  var rnd = Random();
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
    cardNumber = getRandomString(16);
  }

  //Controller for text input
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                RandomAvatar(
                    avatarName,
                    height: 80,
                    width: 80
                ),
                const Text(
                  "Create Account",
                  style: TextStyle(
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
                          child: TextField(
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
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                    onPressed: () async {
                      //set data
                      var data = User(
                          name: nameController.text,
                          cardNumber: cardNumber.toString(),
                          joinDate: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                          avatarString: avatarName

                      );

                      //insert to database
                      await SqliteService.insertUserToDatabase(data);

                      //Go to Home screen
                      await Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.fade, child: MainScreen())
                      );
                    },
                    child: const Text("Create")
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
