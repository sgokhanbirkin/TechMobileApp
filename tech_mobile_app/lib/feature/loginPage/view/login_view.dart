import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:tech_mobile_app/feature/homePage/view/home_view.dart';
import 'package:tech_mobile_app/feature/loginPage/service/login_service.dart';
import 'package:tech_mobile_app/product/text_field_input.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: context.paddingMedium,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Flexible(
                child: Text(
                  'Giriş Yap',
                  style: context.textTheme.headline3,
                ),
                flex: 1,
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter Your Email",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter Your Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await Provider.of<LoginService>(context,
                            listen: false)
                        .signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                        (route) => false);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      _showErrorDialog('E-Mail adresi bulunamadı.',
                          'Lütfen E-Mail adresinizi kontrol ediniz ve tekrar deneyiniz.');
                    } else if (e.code == 'wrong-password') {
                      _showErrorDialog('Şifre yanlış',
                          'Lütfen şifrenizi kontrol ediniz ve tekrar deneyiniz.');
                    } else {
                      _showErrorDialog(
                          'Bir hata oluştu', 'Lütfen tekrar deneyiniz.');
                    }
                  }
                },
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorDialog(String? message1, String? message2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('HATA'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message1!),
                Text(message2!),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
