import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaper {
  String? id;
  String? title;
  String? imageUrl;
  String? description;
  int? timeSeconds;
  List<Questions>? questions;
  int? questionCount;

  QuestionPaper(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.timeSeconds,
      required this.questionCount,
      this.questions});

  QuestionPaper.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    title = json['title'] as String;
    imageUrl = json['image_url'] as String;
    description = json['description'] as String;
    timeSeconds = json['time_seconds'];
    questionCount = 0;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    questions = (json['questions'] as List)
        .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  QuestionPaper.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json['title'];
    imageUrl = json['image_url'];
    description = json['description'];
    timeSeconds = json['time_seconds'];
    questionCount = json['questions_count'] as int;
    questions = [];
  }
  String timeInMinutes() => "${(timeSeconds! / 60).ceil()} mins";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['description'] = description;
    data['time_seconds'] = timeSeconds;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  String? question;
  List<Answers>? answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions({this.id, this.question, this.answers, this.correctAnswer});

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];
  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answers = (json['answer'] as List).map((e) => Answers.fromJson(e)).toList();
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    if (answers != null) {
      data['answer'] = answers!.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    answer = json['answer'];
  }
  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['answer'] = answer;
    return data;
  }
}
