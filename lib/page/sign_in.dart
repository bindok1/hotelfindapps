import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:hotelgo/config/app_asset.dart';
import 'package:hotelgo/config/app_color.dart';
import 'package:hotelgo/config/app_route.dart';
import 'package:hotelgo/source/user_source.dart';
import 'package:hotelgo/widget/button_custom.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();
  //buildContext untuk print info loading

  login(BuildContext context) {
    if (formkey.currentState!.validate()) {
      UserSource.signIn(controllerEmail.text, controllerPassword.text)
          .then((response) {
        if (response['success']) {
          DInfo.dialogSuccess(context, response['message']);
          DInfo.closeDialog(context, actionAfterClose: () {
            Navigator.pushReplacementNamed(context, ApprRoute.home);
          });
        } else {
          DInfo.toastError(response['message']);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder dan constrain untuk membuat sign in saat diketik akan mengikuti keyboard
    return SafeArea(
      child: LayoutBuilder(builder: (context, Constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: Constraints.maxHeight),
              child: Form(
                key: formkey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAsset.logo,
                        // width: 600,
                        // fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign In\nTo Your Account',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerEmail,
                        validator: (value) =>
                            value == '' ? "Don't empty" : null,
                        decoration: InputDecoration(
                            isDense: true,
                            //fill color untuk fill warna
                            fillColor: Colors.white,
                            //content padding untuk cursor ketik
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            hintText: 'Email Address',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controllerPassword,
                        validator: (value) =>
                            value == '' ? "Don't empty" : null,
                        obscureText: true,
                        decoration: InputDecoration(
                            isDense: true,
                            //fill color untuk fill warna
                            fillColor: Colors.white,
                            //content padding untuk cursor ketik
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            hintText: 'Password',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonCustom(
                          label: 'Sign In',
                          isExpand: true,
                          onTap: () => login(context)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Create New Account',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
