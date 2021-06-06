import 'package:ep_contacts_app/models/contact.dart';
import 'package:ep_contacts_app/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactCardSlidable extends StatelessWidget {
  final Contact contact;

  const ContactCardSlidable({Key? key, required this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: ContactCard(contact: contact),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 1 / 4,
      actions: [
        IconSlideAction(
          caption: 'Supprimer',
          color: Colors.red,
          icon: Icons.delete_forever_outlined,
          onTap: () {},
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Sauvegarder',
          color: Colors.green,
          icon: Icons.airline_seat_legroom_reduced_sharp,
          onTap: () {},
        ),
      ],
    );
  }
}
