import 'package:ep_contacts_app/services/auth_helper.dart';
import 'package:flutter/material.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  bool isVisible = false;
  late AuthHelper _helper;
  late String _email, _password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _helper = AuthHelper(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentification"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.person_outline,
                ),
              ),
              onSaved: (email) {
                _email = email ?? "";
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: isVisible,
              //obscuringCharacter: '+',
              decoration: InputDecoration(
                hintText: "Mot de passe",
                prefixIcon: Icon(
                  Icons.lock_outline,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    !isVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                ),
              ),
              onSaved: (pass) {
                _password = pass ?? "";
              },
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      _formKey.currentState?.save();

                      await _helper.registerWithEmailAndPassword(
                        _email,
                        _password,
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60.0,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      _formKey.currentState?.save();
                      print("Email : $_email, Password : $_password");
                      await _helper.signInWithEmailAndPassword(
                        _email,
                        _password,
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60.0,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "Se connecter",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () async {
                await _helper.signInWithGoogle();
                Navigator.pop(context);
              },
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 35.0,
                      width: 35.0,
                      child: Image.asset("assets/images/google.png"),
                    ),
                    Text(
                      "Se connecter avec Google",
                      //style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
