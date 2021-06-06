import 'package:ep_contacts_app/models/contact.dart';
import 'package:ep_contacts_app/screens/add_update_contact_screen.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({
    Key? key,
    required this.contact,
  }) : super(key: key);

  Text makeContactCardLine(String param, dynamic value) {
    return Text("$param : $value");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddUpdateContact(contact: contact),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        //margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            makeContactCardLine("Nom", contact.name),
            SizedBox(height: 5.0),
            makeContactCardLine("Téléphone", contact.phoneNumber),
            SizedBox(height: 5.0),
            makeContactCardLine("Email", contact.email),
          ],
        ),
      ),
    );
  }
}
