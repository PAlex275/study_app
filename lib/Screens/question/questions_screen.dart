import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/Screens/question/test_overview_screen.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_style.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_paper/questions_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/common/question_place_holder.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/countdown_timer.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});
  static const String routeName = '/questionsscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(
                  side: BorderSide(
                    color: onSurfaceTextColor,
                    width: 2,
                  ),
                ),
              ),
              child: Obx(
                () => CountdownTimer(
                  time: controller.time.value,
                  color: onSurfaceTextColor,
                ),
              )),
          showActionIcon: true,
          titleWidget: Obx(
            () => Text(
              'Q ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
              style: appBarTS,
            ),
          ),
        ),
        body: BackgroundDecoration(
          child: Center(
            child: Obx(() => Column(
                  children: [
                    if (controller.loadingStatus.value == LoadingStatus.loading)
                      const Expanded(
                        child: ContentArea(child: QuestionScreenHolder()),
                      ),
                    if (controller.loadingStatus.value ==
                        LoadingStatus.completed)
                      Expanded(
                          child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question
                                    as String,
                                style: questionTS,
                              ),
                              GetBuilder<QuestionsController>(
                                  id: "answers_list",
                                  builder: (context) {
                                    return ListView.separated(
                                      itemCount: controller.currentQuestion
                                          .value!.answers!.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                        top: 25,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                        height: 10,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers![index];

                                        return AnswerCard(
                                          answer:
                                              '${answer.identifier}. ${answer.answer}',
                                          onTap: () {
                                            controller.selectedAnswer(
                                                answer.identifier);
                                          },
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                        );
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )),
                    ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: UIParameters.mobileScreenPadding,
                        child: Row(
                          children: [
                            Visibility(
                              visible: controller.isFirstQuestion,
                              child: SizedBox(
                                width: 55,
                                height: 55,
                                child: MainButton(
                                  onTap: () {
                                    controller.previewsQuestion();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Get.isDarkMode
                                        ? onSurfaceTextColor
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.isLastQuestion
                                        ? Get.toNamed(
                                            TestOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  title: controller.isLastQuestion
                                      ? 'Complete'
                                      : 'Next',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
