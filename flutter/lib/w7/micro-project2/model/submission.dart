import 'package:week3/lecture/w7/micro-project2/model/quiz.dart';

class Submission {
  final List<Answer> answers;

  Submission({required this.answers});

  int getScore() {
    int score = 0;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i].isCorrect()) {
        score++;
      }
    }
    return score;
  }

  Answer? getAnswerFor(Question question) {
    for (var answer in answers) {
      if (answer == question) {
        return answer;
      }
    }
    return null;
  }

  void addAnswer(Question question, String answer) {
    for (var i = 0; i < answers.length; i++) {
      if (answers[i].question == question) {
        answers[i].questionAnswer == answer;
        return;
      }
    }
    answers.add(Answer(questionAnswer: answer, question: question));
  }

  void removeAnswers() {
    answers.clear();
  }
}

class Answer {
  final Question question;
  final String questionAnswer;
  Answer({required this.questionAnswer, required this.question});

  bool isCorrect() {
    return question.goodAnswer == questionAnswer;
  }
}
