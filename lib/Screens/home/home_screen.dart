import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app/Screens/home/menu_screen.dart';
import 'package:study_app/Screens/home/question_card.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text_style.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/widgets/app_circle_button.dart';
import 'package:study_app/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperControler = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            borderRadius: 50.0,
            showShadow: true,
            angle: 0,
            style: DrawerStyle.DefaultStyle,
            backgroundColor: Colors.white.withOpacity(0.5),
            slideWidth: MediaQuery.of(context).size.width * 0.35,
            controller: _.zoomDrawerController,
            menuScreen: const MenuScreen(),
            mainScreen: Container(
                decoration: BoxDecoration(
                  gradient: mainGradient(),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(mobileScreenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCircleButton(
                              onTap: controller.toggleDrawer,
                              child: const Icon(
                                AppIcons.menuLeft,
                                color: onSurfaceTextColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    AppIcons.peace,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Hello friend',
                                    style: detailText.copyWith(
                                        color: onSurfaceTextColor),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'What do you want to learn today?',
                              style: headerText,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemCount:
                                  questionPaperControler.allPapers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return QuestionCard(
                                    model: questionPaperControler
                                        .allPapers[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
