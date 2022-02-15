import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<GoogleSignInAccount?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  return googleUser;
}

Future<void> signOut(GoogleSignInAccount? googleUser) async {
  GoogleSignIn().signOut();
}
