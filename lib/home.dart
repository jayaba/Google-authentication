import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import 'blocks/auth_bloc.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User> loginStateSubcription;

  @override
  void initState() {
    var authBloc=Provider.of<AuthBloc>(context,listen: false);
    loginStateSubcription=authBloc.currentUser.listen((fbuser) {
      if(fbuser==null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
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
        child: StreamBuilder<User>(

          stream: authBloc.currentUser,
          builder: (context, snapshot) {
            if(!snapshot.hasData)return CircularProgressIndicator();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(snapshot.data.displayName),
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(snapshot.data.photoURL),
                ),
                SignInButton(Buttons.Google,text: 'Sign Out Of Google', onPressed: ()=>
authBloc.logout(),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
