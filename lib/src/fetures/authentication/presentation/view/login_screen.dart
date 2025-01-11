import 'package:actify/src/fetures/activation/presentaion/view/activation_home_ba.dart';
import 'package:actify/src/fetures/authentication/presentation/view/forgot_password.dart';
import 'package:actify/src/fetures/home/presentation/view/home_screen.dart';
import 'package:actify/src/services/pantheon_service/acess_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../common_widgets/loader_dialog.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/strings.dart';
import '../../../../services/cloud_logging/logging_provider.dart';
import '../../../../services/cloud_logging/model/log_message/log_message.dart';
import '../../data/user_data_state_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String invalidAuthError = '';
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool obscure = true;

  sendLog() {
    ref.read(cloudLoggingProvider(LogMessage(
        email: email.text,
        message: "User has been logged in successfully",
        type: "info")));
  }

  login() {
    ref.read(cloudLoggingProvider(LogMessage(
        email: email.text,
        message: "User click on sign in button",
        type: "info")));
    showLoaderDialog(context);

    // loginWithEmailAndPassword(email.text, password.text)
    AccessService.login(email.text, password.text).then((user) {
      Navigator.pop(context);
      ref.read(userStateProvider.notifier).setUser(user);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => user.role.toString().toLowerCase() == Strings.supervisor
                  ? const HomeScreen()
                  : const ActivationHomeBAScreen()));
      // ref.read(screenProvider.notifier).change(0);

      // sendLog();
    }).catchError((e) {
      log("catch errorrr $e");
      if (mounted) {
        Navigator.pop(context);
        // ref.read(cloudLoggingProvider(LogMessage(
        //     email: email.text,
        //     message: "Error occurred while signing in",
        //     type: "error",
        //     additionalData: "$e")));
        setState(() {
          invalidAuthError = e.toString().replaceAll(RegExp(r'\[.*?\] '), '');
        });

        // Fluttertoast.showToast(msg: '${e.message}', gravity: ToastGravity.TOP);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future(initLog);
  }

  initLog() {
    ref.read(cloudLoggingProvider(
        LogMessage(message: "User landed on sign in page", type: "info")));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/images/logo_login.png'),
                      height: size.height * 0.22,
                    ),
                    20.height,
                    if (invalidAuthError != '')
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          invalidAuthError,
                        ),
                      ),
                    20.height,
                    TextFormField(
                      controller: email,
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          invalidAuthError = '';
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.blueGrey.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter email*';
                        }
                        return null;
                      },
                    ),
                    8.height,
                    TextFormField(
                      controller: password,
                      autofillHints: const [AutofillHints.password],
                      obscureText: obscure,
                      onChanged: (value) {
                        setState(() {
                          invalidAuthError = '';
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.blueGrey.withOpacity(0.2),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: obscure
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter Password*';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          invalidAuthError = '';
                        });
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => const BottomBarScreen()));
                        if (_formKey.currentState!.validate()) {
                          TextInput.finishAutofillContext(shouldSave: true);
                          login();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Text(
                          'Login',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
