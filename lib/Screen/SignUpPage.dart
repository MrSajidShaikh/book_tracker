import 'package:final_exam/Screen/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/BookController.dart';
import '../srvices/AuthServices/authServices.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(dependency);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUpPage'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: txtEmail,
                decoration: const InputDecoration(
                    hintText: 'Email', enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.black)
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: txtPassword,
                decoration: const InputDecoration(
                    hintText: 'Password', enabledBorder: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Have a Account ??'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ));
                      },
                      child: const Text('Sign In')),
                ],
              ),
              OutlinedButton(
                  onPressed: () {
                    String email = txtEmail.text;
                    String password = txtEmail.text;
                    AuthServices.services.createAccount(email, password);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ));
                    txtEmail.clear();
                    txtPassword.clear();
                  },
                  child: const Text('Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}
