import 'package:ep_contacts_app/models/contact.dart';
import 'package:ep_contacts_app/screens/add_update_contact_screen.dart';
import 'package:ep_contacts_app/services/sqflite_helper.dart';
import 'package:ep_contacts_app/widgets/contact_card_slidable.dart';
import 'package:flutter/material.dart';

class AllContacts extends StatefulWidget {
  @override
  _AllContactsState createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  SqfLiteHelper _helper = SqfLiteHelper();
  bool isLoading = true;
  List<Contact> contactList = [];
  int? nContacts = 0;

  Future<void> initialize() async {
    List<Contact>? cL = await _helper.getAllContact();
    setState(() {
      contactList = cL ?? [];
      nContacts = cL?.length;
      isLoading = false;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Widget getChild() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (nContacts == 0) {
        return Center(
          child: Text("Vous n'avez encore aucun conatct"),
        );
      } else {
        return ListView.separated(
          itemCount: nContacts ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ContactCardSlidable(contact: contactList[index]);
          },
          separatorBuilder: (context, index) => SizedBox(height: 15.0),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUpdateContact(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(padding: EdgeInsets.all(15.0), child: getChild()),
    );
  }
}
