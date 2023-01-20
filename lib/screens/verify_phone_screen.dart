

import 'package:bloc_rohit_semriwal/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class VerifyPhoneScreen extends StatelessWidget {
  VerifyPhoneScreen({Key? key}) : super(key: key);

  final TextEditingController otpController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('verify'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          children: [
           TextField(
             controller: otpController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '6-Digit OTP',
                counterText: '',
              ),
            ),
            SizedBox(height: 16,),

            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                print('listener state:: $state');
                if(state is AuthLoggedInState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),),);
                } else if(state is AuthErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${state.error.toString()}'))
                  );
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
                    child: const Text('Verify'),
                    onPressed: () {

                      BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
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
