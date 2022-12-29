import 'package:contacts/add_edite_screen.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/screen/utils/network.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Network.checkInternet(context);
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (Network.isconnect == true) {
        Network.getdata().then((value) async {
          await Future.delayed(Duration(seconds: 3));
          setState(() {});
        });
      } else {
        Network.showInternetError(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //*
          Addscreen.id = 0;
          Addscreen.namecontroller.text = "";
          Addscreen.phonecontroller.text = "";
          //*
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Addscreen()))
              .then((value) {
            Network.getdata().then((value) async {
              await Future.delayed(Duration(seconds: 5));
              setState(() {});
            });
          });
        },
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "دفترچه تلفن آنلاین",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.import_contacts_sharp,
          size: 30,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Network.checkInternet(context);
                Future.delayed(Duration(seconds: 3)).then((value) {
                  if (Network.isconnect) {
                    Network.getdata().then((value) async {
                      await Future.delayed(Duration(seconds: 3));
                      setState(() {});
                    });
                  } else {
                    Network.showInternetError(context);
                  }
                });
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: Network.contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () async {
              Network.deletecontact(Network.contacts[index].id.toString());
              await Future.delayed(Duration(seconds: 3));
              setState(() {});
            },
            leading: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(fontSize: 17),
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                //*
                Addscreen.id = Network.contacts[index].id;
                Addscreen.namecontroller.text =
                    Network.contacts[index].fullname;
                Addscreen.phonecontroller.text = Network.contacts[index].phone;
                //*
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Addscreen()))
                    .then((value) {
                  Network.getdata().then((value) async {
                    await Future.delayed(Duration(seconds: 5));
                    setState(() {});
                  });
                });
              },
              icon: Icon(
                Icons.edit,
              ),
            ),
            title: Text(
              Network.contacts[index].fullname,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(Network.contacts[index].phone),
          );
        },
      ),
    );
  }
}
