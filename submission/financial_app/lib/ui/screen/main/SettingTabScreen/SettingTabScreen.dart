import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../../data/local/model/User.dart';
import '../../../../data/local/sqlite_service.dart';

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
        children: [
          Row(
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      "Joined since $joinDateFormated",
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "My Finance v${_packageInfo.version}",
            style: const TextStyle(
                color: Colors.white60,
                fontSize: 12
            ),
          ),
          Text(
            "Patricia Fiona ©${DateTime.now().year} | All right reserved",
            style: const TextStyle(
                color: Colors.white60,
                fontSize: 10
            ),
          ),
        ],
      ),
    );
  }
}
