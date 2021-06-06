import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  final BuildContext context;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthHelper(this.context);

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // FlushbarHelper.createSuccess(message: "Votre compte a bien été créé")
      //     .show(context);
      showSnackBar("Votre compte a bien été créé");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // FlushbarHelper.createError(message: "Mot de passe facile à deviner")
        //     .show(context);
        showSnackBar("Mot de passe facile à deviner");
      } else if (e.code == 'email-already-in-use') {
        // FlushbarHelper.createError(message: "Email déjà en cours d'utilisation")
        //     .show(context);
        showSnackBar("Email déjà en cours d'utilisation");
      } else if (e.code == 'invalid-email') {
        //FlushbarHelper.createError(message: "Email invalide").show(context);
        showSnackBar("Email invalide");
      }
    } on SocketException catch (_) {
      // FlushbarHelper.createError(message: "Veuillez vous connecter à internet")
      //     .show(context);
      showSnackBar("Veuillez vous connecter à internet");
    } catch (e) {
      // FlushbarHelper.createError(
      //         message: "Erreur inconnue...Veuillez réessayer !")
      //     .show(context);
      showSnackBar("Erreur inconnue...Veuillez réessayer !");
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        showSnackBar("Votre compte est désactive, contactez admin");
      } else if (e.code == 'user-not-found') {
        showSnackBar("Compte inexistant");
      } else if (e.code == 'invalid-email') {
        showSnackBar("Email invalide");
      } else if (e.code == 'wrong-password') {
        showSnackBar("Mot de passe incorrect");
      }
    } on SocketException catch (_) {
      showSnackBar("Veuillez vous connecter à internet");
    } catch (e) {
      showSnackBar("Erreur inconnue...Veuillez réessayer !");
    }
  }

  /*Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }*/

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
    ]);
    // ou encore
    //await _googleSignIn.signOut();
    // await _auth.signOut();
  }
}
