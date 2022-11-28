import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app/Screens/home/home_screen.dart';
import 'package:study_app/Screens/login/login_screen.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/widgets/dialogs/dialog_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;

  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _authAccount = await account.authentication;
        // ignore: no_leading_underscores_for_local_identifiers
        final _credentials = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
        await _auth.signInWithCredential(_credentials);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (error) {
      print(error);
    }
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl,
    });
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs().questionStartDialog(
        onTap: () {
          Get.back();
          navigateToLoginPage();
        },
      ),
      barrierDismissible: false,
    );
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (exception) {
      print(exception);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }
}
