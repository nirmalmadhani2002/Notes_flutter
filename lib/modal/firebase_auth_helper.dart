import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();

  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FacebookAuth facebookAuth = FacebookAuth.instance;

  Future<Map<String, dynamic>> singUp(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print("================================");
      print(e.code);
      print("================================");
      switch (e.code) {
        case "email-already exists...":
          res['error'] = "Email already exists...";
          break;
        case "weak-password...":
          res['error'] = "Passwoed must be lengthy...";
          break;
        case "operation-not-allowed...":
          res['error'] = "This service is temporary down...";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> singIn(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print("================================");
      print(e.code);
      print("================================");
      switch (e.code) {
        case "email-already-in-use...":
          res['error'] = "This user dose not exists...";
          break;
        case "wrong-pasword...":
          res['error'] = "Wrong Password Try Again...";
          break;
        case "operation-not-allowed...":
          res['error'] = "This service is temporary down...";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> singWithGoogle() async {
    {
      Map<String, dynamic> res = {};
      try {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        User? user = userCredential.user;

        res['user'] = user;
      } on FirebaseAuthException catch (e) {
        print("================================");
        print(e.code);
        print("================================");
        switch (e.code) {
          case "operation-not-allowed...":
            res['error'] = "This service is temporary down...";
            break;
        }
      }
      return res;
    }
  }

  Future<User?> signInAnonymously() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();

    User? user = userCredential.user;

    return user;
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
