import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../components/login_page.dart';
import '../models/person.dart';
import '../screens/home_screen.dart';

class AuthenticationProvider extends ChangeNotifier {
  final firebaseFirestore = FirebaseFirestore.instance;
  final userAuth = FirebaseAuth.instance;
  bool _isLoading = false;
  User? _user;
  bool get isLoading => _isLoading;
  bool get isAuthUser => _user != null;

  Future<void> init() async {
    userAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      _isLoading =true;
      notifyListeners();
      await userAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (error) {
      _isLoading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      return await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: error.toString(),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    await userAuth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }

  Future<void> signUp(
      {required File image,
      required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential credential = await userAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: use_build_context_synchronously
      final urlImage = await uploadImage(image, context);
      final person = Person(
        name: name,
        uid: credential.user!.uid,
        image: urlImage,
        email: email,
      );
      await firebaseFirestore
          .collection('Users')
          .doc(credential.user!.uid)
          .set(person.toJson());
       // ignore: use_build_context_synchronously
       Navigator.pushReplacementNamed(context, HomeScreen.routeName);    
    } on FirebaseAuthException catch (error) {
      _isLoading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      return await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: error.toString(),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      return await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: error.toString(),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await userAuth.sendPasswordResetEmail(email: email);

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginPage.routeName);
    } on FirebaseAuthException catch (error) {
      _isLoading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      return await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: error.toString(),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
      
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> uploadImage(File image, BuildContext context) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebaseAuth = FirebaseAuth.instance;
    try {
      final ref = firebaseStorage
          .ref()
          .child('Profile Images')
          .child(firebaseAuth.currentUser!.uid);

      final task = ref.putFile(image);
      task.snapshotEvents.listen((snapshot) {}, onError: (error) async {
        if (error is FirebaseException && error.code == 'permission-denied') {
          return await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            title: 'Error',
            desc: error.toString(),
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
      });

      String downloadUrl = '';
      await task.whenComplete(() async {
        downloadUrl = await task.snapshot.ref.getDownloadURL();
        notifyListeners();
        // ignore: body_might_complete_normally_catch_error
      }).catchError((error) {
        debugPrint('Error uploading image: $error');
      });

      return downloadUrl;
    } catch (error) {
      debugPrint('Error uploading image: $error');
      return '';
    }
  }
}
