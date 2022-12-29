import 'package:contacts/screen/home_screen.dart';
import 'package:contacts/screen/linces_screen.dart';
import 'package:contacts/screen/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatefulWidget {
  myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

Future<bool> isActive() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isActive") ?? false;
}

class _myappState extends State<myapp> {
  @override
  void initState() {
    Network.checkInternet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Network.getdata();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "دفترچه تلفن انلاین",
      home: FutureBuilder(
          future: isActive(),
          builder: ((context, snapshot) {
            if (snapshot.data == true) {
              return HomeScreen();
            } else {
              return linces();
            }
          })),
    );
  }
}
