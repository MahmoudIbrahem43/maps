import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/constance/colors.dart';
import 'package:maps/constance/strings.dart';
import 'package:maps/presentation/widgets/custom_alertDialog.dart';
import 'package:maps/presentation/widgets/custom_country_flag.dart';
import 'package:maps/presentation/widgets/custom_elevation_button.dart';

class LoginScreen extends StatelessWidget {
  String? phoneNumber;
  final GlobalKey<FormState> _myKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _myKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 15),
                child: Text(
                  'What is your phone number?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  'Please ener your phone number to \n verify your account.',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.lightGrey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      height: 50,
                      width: 100,
                      child: Center(child: CustomCountryFlage()),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    height: 50,
                    width: 240,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      cursorColor: MyColors.blue,
                      style: TextStyle(fontSize: 17, letterSpacing: 2.0),
                      decoration: InputDecoration(border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter for a phone number!';
                        } else if (value.length < 11) {
                          return 'Too short for a phone number!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phoneNumber = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 270),
                child: Container(
                  child: CustomElevationButton(
                    text: 'Next',
                    onTap: () {
                      showProgressIndicator(context);
                      _register(context);
                    },
                  ),
                  height: 45,
                  width: 120,
                ),
              ),
              _buildPhoneNumberSubmitedBloc()
            ],
          ),
        ),
      ),
    );
  }

  //we used Block listener because of we need to navigate from screen to other only
  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneNumberSubmit) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
        }

        if (state is ErrorOccurred) {
          Navigator.pop(context);
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

  Future<void> _register(BuildContext context) async {
    if (!_myKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _myKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitPhoneNumber(phoneNumber!); //make block not lazy
    }
  }
}
