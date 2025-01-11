
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../common_widgets/loader_dialog.dart';
import '../../../../constants/colors.dart';
import '../../data/auth_provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: const AssetImage('assets/images/logo_login.png'),height: size.height*0.22,),
            12.height,
            const Text(
              'Forgot Password?',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            20.height,
            TextFormField(
              controller: email,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  )),
              validator: (val) {
                final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val!);
                return emailValid ? null : "Enter Valid Email";
              },
            ),
            20.height,
            GestureDetector(
              onTap: () {
                showLoaderDialog(context);
                recoverAccount(email.text).then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: 'Recovery Email Sent to ${email.text}',gravity: ToastGravity.TOP);
                }).catchError((e) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'Error $e',gravity: ToastGravity.TOP);
                });
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Recover',
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            12.height,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text.rich(TextSpan(
                  text: 'Already have an account, ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Login',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
