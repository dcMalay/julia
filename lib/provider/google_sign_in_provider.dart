import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/verify_google_signin_user.dart';
import '../views/home.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleSignIn == null) return;
      _user = googleUser;

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("credential ---->>${credential.accessToken}");

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
      if (FirebaseAuth.instance.currentUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        print(credential.accessToken);
        await gettokenforGlogin(credential.accessToken!);
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Home(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                        .animate(animation),
                child: child,
              );
            },
          ),
        );
      }

      // var user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
