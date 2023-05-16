import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:basic_auth/globals.dart";

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name;
  String? imageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  String? userEmail;

  Future<User?> registerWithEmailPassword(String email, String password) async {
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return user;
  }

  signInWithGoogle() async {
    // begin interactive sign in process
    await Firebase.initializeApp();
    User? user;

    // The `GoogleAuthProvider` can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      myUserData.uid = user.uid;
      myUserData.name = user.displayName ?? "Default Name";
      myUserData.email = user.email ?? "";
      myUserData.imagePath = user.photoURL ?? "";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);


      print(
          "uID: ${uid} \n name: ${myUserData.name} \n email: ${myUserData.email} \n imageURL ${myUserData.imagePath}");
      print("Prefs: $prefs");
    }
    print("User Print from auth service: ${user}");

    return user;
  }

  /*

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
    */
}
