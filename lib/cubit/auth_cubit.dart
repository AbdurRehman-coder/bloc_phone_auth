
import 'package:bloc_rohit_semriwal/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

  AuthCubit() : super(AuthInitialState()){
    User? currentUser = FirebaseAuth.instance.currentUser;
    print('current user: ${currentUser}');
    if(currentUser != null){
      emit(AuthLoggedInState());
    } else{
      emit(AuthLoggedOutState());
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;
  void sendOTP(String phoneNumber) async{
    /// emit loading state for showing circular indicator
     emit(AuthLoadingState());
     await FirebaseAuth.instance.verifyPhoneNumber(
       phoneNumber: phoneNumber,
         verificationCompleted: (phoneAuthCredential) {
         // signInWithPhone(phoneAuthCredential);
         },
         verificationFailed: (error) {
         print('verificationFailed error::: ${error}');
         },
         codeSent: ((verificationId, forceResendingToken) {
           print('codeSent: $verificationId ,, $forceResendingToken');
           _verificationId = verificationId;

           emit(AuthCodeSentState());
         }),

         codeAutoRetrievalTimeout: (verificationId) {

         },
       timeout: Duration(seconds: 60),

     );
  }
  void verifyOTP(String otp){
    /// emit loading state for showing circular indicator
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }
  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if(userCredential.user != null){
        emit(AuthLoggedInState(firebaseUser: userCredential.user));
      }
    } on FirebaseAuthException catch(ex){
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void logout() async{
    await FirebaseAuth.instance.signOut();
    emit(AuthLoggedOutState());
  }
}