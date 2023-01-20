

import 'package:bloc_rohit_semriwal/cubit/auth_cubit.dart';
import 'package:bloc_rohit_semriwal/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen'),
      ),
      body: Container(
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is AuthLoggedOutState){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => SignInScreen()));
              }
            },
            builder: (context, state) {
              return CupertinoButton(
                onPressed: () {
                  /// Call Logout function inside AuthCubit
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                child: Text('Logout',
                  style: TextStyle(fontSize: 22, color: Colors.cyan),),
              );
            },
          )
        ),
      ),
    );
  }
}
