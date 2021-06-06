import 'package:ep_contacts_app/models/contact.dart';
import 'package:ep_contacts_app/utils/regex.dart';
import 'package:ep_contacts_app/services/sqflite_helper.dart';
import 'package:flutter/material.dart';

class AddUpdateContact extends StatefulWidget {
  final Contact? contact;

  const AddUpdateContact({
    Key? key,
    this.contact,
  }) : super(key: key);
  @override
  _AddUpdateContactState createState() => _AddUpdateContactState();
}

class _AddUpdateContactState extends State<AddUpdateContact> {
  late bool switchValue;
  late int radioGroupValue;
  bool shouldIValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name, _phoneNumber, _email, _description;
  SqfLiteHelper _helper = SqfLiteHelper();

  @override
  void initState() {
    if (widget.contact == null) {
      switchValue = false;
      radioGroupValue = 3;
    } else {
      switchValue = widget.contact?.isFavorite ?? false;
      radioGroupValue = widget.contact?.sex ?? 3;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.contact != null
            ? Text("Modifier eP Contact")
            : Text("Ajouter eP Contact"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextFormField(
                autovalidateMode: shouldIValidate
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                initialValue:
                    widget.contact != null ? widget.contact?.name : "",
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Nom et Prenom du contact",
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
                validator: (value) {
                  if ((value == null) || (value.trim().length == 0)) {
                    return "Le nom ne peut être vide";
                  }
                  return null;
                },
                onSaved: (nameInField) {
                  _name = nameInField;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                autovalidateMode: shouldIValidate
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                initialValue:
                    widget.contact != null ? widget.contact?.phoneNumber : "",
                keyboardType: TextInputType.phone,
                maxLength: 8,
                decoration: InputDecoration(
                  hintText: "Téléphone",
                  prefixIcon: Icon(
                    Icons.call,
                  ),
                ),
                validator: (v) {
                  String value = v?.trim() ?? "";
                  if ((value.trim().length == 8) &&
                      digitsRegex.hasMatch(value)) {
                    return null;
                  }
                  return "Numéro incorrect";
                },
                onSaved: (phoneNumberInField) {
                  _phoneNumber = phoneNumberInField;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                autovalidateMode: shouldIValidate
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                initialValue:
                    widget.contact != null ? widget.contact?.email : "",
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
                validator: (v) {
                  String value = v?.trim() ?? "";
                  if (emailRegex.hasMatch(value)) {
                    return null;
                  }
                  return "Email incorrect";
                },
                onSaved: (emailInField) {
                  _email = emailInField;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                autovalidateMode: shouldIValidate
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                initialValue:
                    widget.contact != null ? widget.contact?.desc : "",
                keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: null,
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: "Description du contact",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onSaved: (descInField) {
                  _description = descInField;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Favoris ?"),
                  Switch(
                    value: switchValue,
                    onChanged: (v) {
                      setState(() {
                        switchValue = v;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio(
                    onChanged: (_) {
                      setState(() {
                        radioGroupValue = 1;
                      });
                    },
                    groupValue: radioGroupValue,
                    value: 1,
                  ),
                  Text("Homme"),
                  Radio(
                    onChanged: (_) {
                      setState(() {
                        radioGroupValue = 2;
                      });
                    },
                    groupValue: radioGroupValue,
                    value: 2,
                  ),
                  Text("Femme"),
                  Radio(
                    onChanged: (_) {
                      setState(() {
                        radioGroupValue = 3;
                      });
                    },
                    groupValue: radioGroupValue,
                    value: 3,
                  ),
                  Text("Autre"),
                ],
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  bool b = _formKey.currentState?.validate() ?? false;
                  setState(() {
                    shouldIValidate = true;
                  });
                  if (b) {
                    _formKey.currentState?.save();
                    Contact _c = Contact(
                      id: widget.contact == null ? null : widget.contact?.id,
                      name: _name ?? "",
                      phoneNumber: _phoneNumber ?? "",
                      email: _email ?? "",
                      isFavorite: switchValue,
                      desc: _description,
                      sex: radioGroupValue,
                    );
                    widget.contact == null
                        ? await _helper.insert(_c)
                        : await _helper.update(_c);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 60.0,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: widget.contact != null
                      ? Text(
                          "Modifier",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          "Enregister",
                          style: TextStyle(color: Colors.white),
                        ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
