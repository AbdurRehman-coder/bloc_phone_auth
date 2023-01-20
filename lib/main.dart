import 'package:bloc_rohit_semriwal/cubit/auth_cubit.dart';
import 'package:bloc_rohit_semriwal/screens/home_screen.dart';
import 'package:bloc_rohit_semriwal/screens/sign_in_screen.dart';
import 'package:bloc_rohit_semriwal/screens/verify_phone_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_state.dart';


void main() async{
  print('1');
  WidgetsFlutterBinding.ensureInitialized();
  print('2');
  await Firebase.initializeApp(
      // name: 'blocPhoneAuth',
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyAfrFLhzKDR6LHeawRf6rOhZ_McAoqICiM",
      //
      //     authDomain: "blocphoneauth-1e9c3.firebaseapp.com",
      //
      //     projectId: "blocphoneauth-1e9c3",
      //
      //     storageBucket: "blocphoneauth-1e9c3.appspot.com",
      //
      //     messagingSenderId: "392862986473",
      //
      //     appId: "1:392862986473:web:f0a0623b5d76f0df6a4078",
      //
      //     measurementId: "G-LG8R5WZC4J"
      //
      // )
  );
  print('3');
  runApp(const MyApp());
  print('4');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),


        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => previous is AuthInitialState,
          builder: (context, state) {
            print('listener state at main:: $state');
            if(state is AuthLoggedInState){
             return HomeScreen();
            } else if(state is AuthLoggedOutState){
              return SignInScreen();
            } else{
              return const Scaffold(
                backgroundColor: Colors.amberAccent,
              );
            }
          },
        ),
      ),
    );
  }
}

