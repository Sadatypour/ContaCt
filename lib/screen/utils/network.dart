import 'dart:convert' as Convert;
import 'dart:ffi';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:contacts/models/contact.dart';
import 'package:http/http.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Network {
//!connect Internet
  static bool isconnect = false;
  static Future<bool> checkInternet(BuildContext context) async {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile) {
        isconnect = true;
      } else {
        isconnect = false;
        showInternetError(context);
      }
      print(Network.isconnect);
    });
    return isconnect;
  }

//**** */
//!show enternet
  static void showInternetError(BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "خطا",
        width: 100,
        text: "عدم اتصال به اینترنت",
        confirmBtnText: "OK",
        confirmBtnTextStyle:
            TextStyle(fontSize: 16, color: Color.fromARGB(255, 220, 183, 227)),
        confirmBtnColor: Colors.purpleAccent);
  }

//**** */
  static Uri Url = Uri.parse("https://retoolapi.dev/ukKzU2/cantacts");
  static Uri urlwithid(String id) {
    Uri url = Uri.parse('https://retoolapi.dev/ukKzU2/cantacts/$id');
    return url;
  }

  //!get data
  static List<Contact> contacts = [];

  static Future<void> getdata() async {
    contacts.clear();
    http.get(Network.Url).then((Response) {
      if (Response.statusCode == 200) {
        List JsonDecode = Convert.jsonDecode(Response.body);
        for (var json in JsonDecode) {
          contacts.add(Contact.fromJson(json));
        }
      }
    });
  }

  //!post contatct
  static Future<void> postData(
      {required String phone, required String fullname}) async {
    Contact contact = Contact(
      phone: phone,
      fullname: fullname,
    );
    http.post(Network.Url, body: contact.toJson()).then((Response) {
      print(Response.body);
    });
  }

  //!put contatct
  static Future<void> putData(
      {required String phone,
      required String fullname,
      required String id}) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    http.put(urlwithid(id), body: contact.toJson()).then((Response) {
      print(Response.body);
    });
  }

  //!delete contact
  static void deletecontact(String id) {
    http.delete(Network.urlwithid(id)).then((value) {
      getdata();
    });
  }
}
