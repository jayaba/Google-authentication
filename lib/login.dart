import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_login/blocks/auth_bloc.dart';
import 'package:google_login/home.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription<User> loginStateSubcription;

  @override
  void initState() {
    var authBloc=Provider.of<AuthBloc>(context,listen: false);
    loginStateSubcription=authBloc.currentUser.listen((fbuser) {
      if(fbuser!=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    loginStateSubcription.cancel();
    super.dispose();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    final authBloc=Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,onPressed: ()=>
                  authBloc.loginGoogle(),

            ),
          ],
        ),
      ),
    ); 
  }
}
