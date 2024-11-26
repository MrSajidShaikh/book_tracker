import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/BookController.dart';
import '../srvices/AuthServices/authServices.dart';
import 'HomePage.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(dependency);
    return Scaffold(
      appBar: AppBar(
        title: Text('SignINPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                  hintText: 'Email', enabledBorder: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtPassword,
              decoration: InputDecoration(
                  hintText: 'Password', enabledBorder: OutlineInputBorder()),
            ),
            OutlinedButton(
                onPressed: () {
                  String email = txtEmail.text;
                  String password = txtEmail.text;
                  AuthServices.services.signInAccount(email, password);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ));
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
