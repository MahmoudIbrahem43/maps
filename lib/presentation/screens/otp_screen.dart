import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/constance/colors.dart';
import 'package:maps/constance/strings.dart';
import 'package:maps/presentation/widgets/custom_alertDialog.dart';
import 'package:maps/presentation/widgets/custom_elevation_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final phoneNumber;
  late String otpCode;

  OtpScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 2, right: 22),
                child: Text(
                  'verify your phone number?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Enter your 6 digit code numbers sent to you at ',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 210),
                child: Text(
                  '$phoneNumber',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              _buildPinCodeFields(context),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 240),
                child: Container(
                  height: 45,
                  width: 120,
                  child: CustomElevationButton(
                    text: 'verify',
                    onTap: () {
                      showProgressIndicator(context);
                      _login(context);
                    },
                  ),
                ),
              ),
              _buildPhoneVerificationBloc()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: PinCodeTextField(
          appContext: context,
          autoFocus: true,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            borderWidth: 1,
            activeColor: MyColors.blue,
            inactiveColor: MyColors.blue,
            inactiveFillColor: Colors.white,
            activeFillColor: MyColors.lightBlue,
            selectedColor: MyColors.blue,
            selectedFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          onCompleted: (submitedCode) {
            otpCode = submitedCode;
            print("Completed");
          },
          onChanged: (value) {
            print(value);
          },
        ),
      ),
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }

        if (state is ErrorOccurred) {
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTB(otpCode);
  }
}
