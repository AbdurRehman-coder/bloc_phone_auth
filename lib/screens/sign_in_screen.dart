

import 'package:bloc_rohit_semriwal/cubit/auth_cubit.dart';
import 'package:bloc_rohit_semriwal/cubit/auth_state.dart';
import 'package:bloc_rohit_semriwal/screens/verify_phone_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In'),),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              maxLength: 11,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone number',
                counterText: '',
              ),
            ),
            SizedBox(height: 16,),


            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                print('listener state:: $state');
                if(state is AuthCodeSentState){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => VerifyPhoneScreen(),),);
                }
              },
                builder: (context, state) {
                  print('builder state:: $state');
                  if(state is AuthLoadingState){
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  return  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CupertinoButton(
                      color: Colors.blueAccent,
                      child: const Text('Sign in'),
                      onPressed: () {
                        String phoneNumber = '+92${phoneController.text}';
                        // String phoneNumber = '${phoneController.text}';
                        BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                      },
                    ),
                  );

                },


            ),


          ],
        ),
      ),
    );
  }
}
