import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/instance_manager.dart';
import 'package:study_app/Screens/Introduction/introduction.dart';
import 'package:study_app/Screens/Splash/splash_screen.dart';
import 'package:study_app/Screens/home/home_screen.dart';
import 'package:study_app/Screens/login/login_screen.dart';
import 'package:study_app/Screens/question/answer_check_screen.dart';
import 'package:study_app/Screens/question/questions_screen.dart';
import 'package:study_app/Screens/question/result_screen.dart';
import 'package:study_app/Screens/question/test_overview_screen.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/controllers/question_paper/questions_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: "/introduction",
          page: () => const AppIntroductionScreen(),
        ),
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuestionPaperController());
            Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: QuestionsScreen.routeName,
          page: () => const QuestionsScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionsController>(QuestionsController());
          }),
        ),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        ),
      ];
}
