import 'package:financial_app/ui/widget/RowTextDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../../data/local/model/User.dart';
import '../../../../data/local/sqlite_service.dart';
import '../../../../utils/CustomColors.dart';
import '../../createUpdateAccount/CreateUpdateAccountScreen.dart';

class SettingTabScreen extends StatefulWidget {
  const SettingTabScreen({super.key});

  @override
  State<SettingTabScreen> createState() => _SettingTabScreenState();
}

class _SettingTabScreenState extends State<SettingTabScreen> {
  User userData = User(name: "", cardNumber: "", joinDate: "", avatarString: "");
  String joinDateFormated = "";

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    SqliteService.getUser().then((data) {
      setState(() {
        userData = data;

        var tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(userData.joinDate);
        joinDateFormated = DateFormat.yMMMMd().format(tempDate).toString();
      });
    });

    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  RandomAvatar(
                      userData.avatarString,
                      height: 50,
                      width: 50
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userData.name,
                          style: TextStyle(
                            color: purplishBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        Text(
                          "Joined since $joinDateFormated",
                          style: TextStyle(
                              color: punchOutGlove,
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const CreateUpdateAccountScreen(action: "update")));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: californiaGirl,
                        size: 18,
                      )
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Application",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.phone_android_outlined,
                      size: 20,
                        color: Colors.grey,
                    )
                  ],
                ),
                const Divider(),
                const RowTextDetail(title: "Developer", detail: "Patricia Fiona"),
                const Divider(),
                const RowTextDetail(title: "Language", detail: "Flutter"),
                const Divider(),
                const RowTextDetail(title: "Compatibility", detail: "Android & iOS"),
                const Divider(),
                const RowTextDetail(title: "Designer", detail: "Mohammad Jabel @ Dribbble"),
                const Divider(),
                RowTextDetail(title: "App version", detail: "v${_packageInfo.version}"),
                const Divider(),
                RowTextDetail(title: "App package", detail: _packageInfo.packageName),
                const Divider(),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    "My Finance v${_packageInfo.version}",
                    style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 10
                    ),
                  ),
                  Text(
                    "Patricia Fiona ©${DateTime.now().year} | All right reserved",
                    style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 8
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
