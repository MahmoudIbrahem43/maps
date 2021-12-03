import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;
  PhoneAuthCubit() : super(PhoneAuthInitial());

  //take a phonenumber and send verficationcode and auto read it and handle error if failed
  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //auto handling'reading' a verificationcode after sending
  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  //when you enter a wrong phone number
  void verificationFailed(FirebaseException error) {
    print('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  //when code sent sucsessfuly on my phone emit for the phone number sbmit
  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    print('code sent');
    emit(PhoneNumberSubmit());
  }

  //combare between code i write manully and code which sent if the device didn't read it automaticly
  Future<void> submitOTB(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: this.verificationId,
      smsCode: otpCode,
    );
    await signIn(credential);
  }

  //if you entered verification code right sign in else handle error
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User fireBaseUser = FirebaseAuth.instance.currentUser!;
    return fireBaseUser;
  }
}

