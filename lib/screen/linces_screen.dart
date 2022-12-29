import 'dart:convert';
import 'dart:io';

import 'package:contacts/screen/home_screen.dart';
import 'package:contacts/screen/widgets/MyTextField.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class linces extends StatelessWidget {
  linces({Key? key}) : super(key: key);

  Future<String?> getDeviceId() async {
    var Deviceinfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosdevice = await Deviceinfo.iosInfo;
      return iosdevice.identifierForVendor;
    } else {
      var androiddeviceinfo = await Deviceinfo.androidInfo;
      return androiddeviceinfo.androidId;
    }
  }

  void showsuccess(BuildContext context) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      width: 100,
      title: "موفق",
      text: "کد با موفقیت کپی شد",
      confirmBtnText: "باشه",
      confirmBtnColor: Colors.purpleAccent,
      backgroundColor: Color.fromARGB(255, 225, 159, 237),
    );
  }

  final TextEditingController systemcode = TextEditingController();
  final TextEditingController activecode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getDeviceId().then(((value) {
      systemcode.text = value ?? "";
    }));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "فعال سازی",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: systemcode.text));
                showsuccess(context);
              },
              child: MyTextField(
                  isenable: false,
                  errortext: "",
                  inputType: TextInputType.text,
                  controller: systemcode,
                  labeltext: "کد سیستم"),
            ),
            SizedBox(
              height: 40,
            ),
            MyTextField(
                errortext: "",
                inputType: TextInputType.number,
                controller: activecode,
                labeltext: "کد فعالسازی"),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                var bytes1 = utf8.encode(systemcode.text);
                var digest1 = sha512256.convert(bytes1);
                print(digest1);
                if (activecode.text == digest1.toString()) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool("isActive", true);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => (HomeScreen()))));
                }
              },
              child: Text("فعال سازی"),
              style: TextButton.styleFrom(
                fixedSize: Size(300, 50),
                backgroundColor: Colors.purpleAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
