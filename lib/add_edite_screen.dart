import 'package:contacts/screen/utils/network.dart';
import 'package:contacts/screen/widgets/MyTextField.dart';
import 'package:flutter/material.dart';

class Addscreen extends StatefulWidget {
  static TextEditingController namecontroller = TextEditingController();
  static TextEditingController phonecontroller = TextEditingController();
  static int id = 0;
  Addscreen({Key? key}) : super(key: key);

  @override
  State<Addscreen> createState() => _AddscreenState();
}

class _AddscreenState extends State<Addscreen> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text(Addscreen.id == 0 ? "مخاطب جدید" : "ویرایش مخاطب"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
          child: Column(
            children: [
              MyTextField(
                  errortext: "نام را وارد کنید",
                  inputType: TextInputType.name,
                  controller: Addscreen.namecontroller,
                  labeltext: "نام"),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                  errortext: "شماره را وارد کنید",
                  inputType: TextInputType.number,
                  controller: Addscreen.phonecontroller,
                  labeltext: "شماره"),
              SizedBox(
                height: 70,
              ),
              Container(
                width: 280,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Network.checkInternet(context);
                      Future.delayed(Duration(seconds: 3)).then(
                        (value) {
                          if (Network.isconnect) {
                            if (Addscreen.id == 0) {
                              Network.postData(
                                phone: Addscreen.phonecontroller.text,
                                fullname: Addscreen.namecontroller.text,
                              );
                            } else {
                              Network.putData(
                                  phone: Addscreen.phonecontroller.text,
                                  fullname: Addscreen.namecontroller.text,
                                  id: Addscreen.id.toString());
                            }
                            Navigator.pop(context);
                          } else {
                            Network.showInternetError(context);
                          }
                        },
                      );
                    }
                  },
                  child: Text(Addscreen.id == 0 ? "اضافه کردن" : "ویرایش کردن"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/backtop.png",
                width: 250,
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
