import 'package:ep_contacts_app/models/contact.dart';
import 'package:ep_contacts_app/services/sqflite_helper.dart';
import 'package:ep_contacts_app/widgets/contact_card_slidable.dart';
import 'package:flutter/material.dart';

class FavoritesContacts extends StatefulWidget {
  @override
  _FavoritesContactsState createState() => _FavoritesContactsState();
}

class _FavoritesContactsState extends State<FavoritesContacts> {
  SqfLiteHelper _helper = SqfLiteHelper();
  bool isLoading = true;
  List<Contact> contactList = [];
  int? nContacts = 0;

  Future<void> initialize() async {
    List<Contact>? cL = await _helper.getFavorites();
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
          child: Text("Vous n'avez encore aucun favoris"),
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
      body: Padding(padding: EdgeInsets.all(15.0), child: getChild()),
    );
  }
}
