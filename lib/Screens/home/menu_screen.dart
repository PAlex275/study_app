import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: onSurfaceTextColor,
            ),
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    controller.toggleDrawer();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.user.value == null
                        ? const SizedBox()
                        : Text(
                            controller.user.value!.displayName ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: onSurfaceTextColor,
                            ),
                          )),
                    const Spacer(flex: 1),
                    _DrawerButton(
                      icon: Icons.web,
                      lable: 'Website',
                      onPressed: () => controller.website(),
                    ),
                    _DrawerButton(
                      icon: Icons.facebook,
                      lable: 'Facebook',
                      onPressed: () => controller.facebook(),
                    ),
                    _DrawerButton(
                      icon: Icons.camera_enhance_outlined,
                      lable: 'Instagram',
                      onPressed: () => controller.instagram(),
                    ),
                    _DrawerButton(
                      icon: Icons.email,
                      lable: 'Email',
                      onPressed: () => controller.email(),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    _DrawerButton(
                      icon: Icons.logout,
                      lable: 'Logout',
                      onPressed: () => controller.signOut(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {super.key,
      required this.icon,
      required this.lable,
      required this.onPressed});
  final IconData icon;
  final String lable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        icon,
        size: 15,
      ),
      label: Text(lable),
      onPressed: onPressed,
    );
  }
}
