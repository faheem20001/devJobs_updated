import 'package:firebase_auth/firebase_auth.dart';

class ForgotService{

Future<void> ForgotPassword(String _ForgotEmailController)async {
FirebaseAuth.instance.sendPasswordResetEmail(email: _ForgotEmailController);
}
}