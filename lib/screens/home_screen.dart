

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media/components/login_page.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const routeName = 'home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const  Text('Hey'),
        centerTitle: true,
        leading: IconButton(
          onPressed:(){
             FirebaseAuth.instance.signOut();
             Navigator.pushNamed(context, LoginPage.routeName);
          },
          icon:Icon(Icons.logout)
          ),
      ),
      body:const Center(
        child: Text('Sucess'),
      )
    );
  }
}
