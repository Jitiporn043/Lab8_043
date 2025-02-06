import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    // Trigger the authentication flow
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //   // Obtain the auth details from the request
    //   final GoogleSignInAuthentication? googleAuth =
    //       await googleUser?.authentication;

    //   // Create a new credential
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth?.accessToken,
    //     idToken: googleAuth?.idToken,
    //   );
    //   UserCredential userCredential =
    //       await FirebaseAuth.instance.signInWithCredential(credential);

    //   print(userCredential);

    //  return userCredential;
  }

  Future<void> googleSignOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
