import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices {
  AuthServices._();

  static final AuthServices services = AuthServices._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createAccount(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    Get.snackbar('Firebase', 'Create Account Successfully!....');
  }

  Future<void> signInAccount(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    Get.snackbar('Firebase', 'Sign IN Account Successfully!....');
  }
}
