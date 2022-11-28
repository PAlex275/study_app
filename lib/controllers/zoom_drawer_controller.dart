import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/auth_controller.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();
  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void website() {
    //_launch('https://alexpetrisor.me');
  }

  void facebook() {
    // _launch('https://www.facebook.com/petrisoralex27/');
  }

  void instagram() {
    // _launch('https://www.instagram.com/p.alex275/');
  }

  void email() {
    // final Uri emailLaunchUri =
    //     Uri(scheme: 'mailto', path: 'alex_petrisor2001@yahoo.com');
    // _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {}
}
