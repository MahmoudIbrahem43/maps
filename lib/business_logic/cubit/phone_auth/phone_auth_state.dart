part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}


//initial state
class PhoneAuthInitial extends PhoneAuthState {}


//loading state >check not report
class Loading extends PhoneAuthState {}


//error state ..
class ErrorOccurred extends PhoneAuthState {
  late String errorMsg;
  ErrorOccurred({required this.errorMsg});
}


//phone number entered successfully..
class PhoneNumberSubmit extends PhoneAuthState {}


//otp code entered successfully ..
class PhoneOTPVerified extends PhoneAuthState {}
