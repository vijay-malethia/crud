import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUsr = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUsr!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
