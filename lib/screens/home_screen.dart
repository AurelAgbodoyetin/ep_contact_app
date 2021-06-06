import 'package:ep_contacts_app/screens/all_contacts_tab.dart';
import 'package:ep_contacts_app/screens/authentification_screen.dart';
import 'package:ep_contacts_app/screens/favorites_contacts_tab.dart';
import 'package:flutter/material.dart';

class ContactAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("eP Contact App"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authentification(),
                  ),
                );
              },
              icon: Icon(Icons.backup),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Tout",
                icon: Icon(Icons.people),
              ),
              Tab(
                text: "Favoris",
                icon: Icon(Icons.star),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllContacts(),
            FavoritesContacts(),
          ],
        ),
      ),
    );
  }
}
