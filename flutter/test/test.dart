import 'package:week3/w7/micro-project2/model/quiz.dart';
import 'package:week3/w7/micro-project2/model/submission.dart';

void main() {

  const Question question1 = Question(title: "What is 2 + 2?",possibleAnswers: ["2","3","1","4"], goodAnswer: "4");
  const Question question2 = Question(title: "What is the capital of Cambodia?",possibleAnswers: ["phnom penh","paris", "bangkok", "saigon"], goodAnswer: "phnom penh");

  Submission submission = Submission(answers: []);

  submission.addAnswer(question1, "4"); 
  submission.addAnswer(question2, "London"); 

  submission.getScore();
  print("Score: ${submission.getScore()}");

  Answer? answer = submission.getAnswerFor(question1);
  if (answer != null) {
    print("Answer for question1: ${answer.questionAnswer}"); // Output: Answer for question1: 4
  }

  submission.removeAnswers();
  print("Answers after removal: ${submission.answers.length}"); // Output: 0
}
