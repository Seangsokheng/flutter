// Participant Class with validation and better naming
import 'dart:io';
class Participant {
  final String firstName;
  final String lastName;
  
  Participant(this.firstName, this.lastName) {
    if (firstName.isEmpty || lastName.isEmpty) {
      throw ArgumentError('First name and last name cannot be empty');
    }
  }

  String get fullName => '$firstName $lastName';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Participant &&
          firstName == other.firstName &&
          lastName == other.lastName;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}

// Result Class with percentage calculation
class Result {
  final Participant participant;
  final int score;
  final int totalQuestions;

  Result(this.participant, this.score, this.totalQuestions) {
    if (score < 0 || score > totalQuestions) {
      throw ArgumentError('Invalid score range');
    }
  }

  double get percentageScore => (score / totalQuestions) * 100;
  
  @override
  String toString() => 
    '${participant.fullName}: $score/$totalQuestions (${percentageScore.toStringAsFixed(1)}%)';
}

// Enhanced Question class with better validation
abstract class Question {
  final String title;
  final List<String> options;
  final List<int> correctAnswers;

  Question(this.title, this.options, this.correctAnswers) {
    if (title.isEmpty) {
      throw ArgumentError('Question title cannot be empty');
    }
    if (options.isEmpty) {
      throw ArgumentError('Options cannot be empty');
    }
    if (correctAnswers.isEmpty) {
      throw ArgumentError('Must provide correct answers');
    }
    for (var answer in correctAnswers) {
      if (answer < 0 || answer >= options.length) {
        throw ArgumentError('Invalid correct answer index');
      }
    }
  }

  bool isCorrect(List<int> answer);
  
  String get questionType;
}

class SingleChoiceQuestion extends Question {
  SingleChoiceQuestion(String title, List<String> options, int correctAnswer)
      : super(title, options, [correctAnswer]) {
    if (options.length < 2) {
      throw ArgumentError('Single choice questions must have at least 2 options');
    }
  }

  @override
  bool isCorrect(List<int> answer) {
    if (answer.length != 1) {
      return false;  // Single choice must have exactly one answer
    }
    return answer[0] == correctAnswers[0];
  }
  
  @override
  String get questionType => 'SingleChoice';
}

class MultipleChoiceQuestion extends Question {
  MultipleChoiceQuestion(String title, List<String> options, List<int> correctAnswers)
      : super(title, options, correctAnswers) {
    if (correctAnswers.length < 2) {
      throw ArgumentError('Multiple choice questions must have at least 2 correct answers');
    }
  }

  @override
  bool isCorrect(List<int> answer) {
    if (answer.isEmpty) return false;
    var answerSet = answer.toSet();
    var correctSet = correctAnswers.toSet();
    return answerSet.length == answer.length && // No duplicates
           answerSet.containsAll(correctSet) && 
           correctSet.containsAll(answerSet);
  }
  
  @override
  String get questionType => 'MultipleChoice';
}

class Quiz {
  final String title;
  final List<Question> questions = [];
  final Map<Participant, Result> results = {};

  Quiz(this.title) {
    if (title.isEmpty) {
      throw ArgumentError('Quiz title cannot be empty');
    }
  }

  void addQuestion(Question question) {
    questions.add(question);
  }

  void submitAnswers(Participant participant, List<List<int>> answers) {
    if (answers.length != questions.length) {
      throw ArgumentError('Number of answers must match number of questions');
    }

    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      try {
        if (questions[i].isCorrect(answers[i])) {
          score++;
        }
      } catch (e) {
        throw ArgumentError('Invalid answer format for question ${i + 1}');
      }
    }

    results[participant] = Result(participant, score, questions.length);
  }

  void displayResults() {
    if (results.isEmpty) {
      print('No results available.');
      return;
    }

    print('\nQuiz Results for: $title');
    print('Total Questions: ${questions.length}\n');
    
    var sortedResults = results.values.toList()
      ..sort((a, b) => b.score.compareTo(a.score));
      
    for (var result in sortedResults) {
      print(result);
    }
  }
}

// Previous classes remain the same (Participant, Result, Question, etc.)
// Adding new Menu handling class and improving main

class QuizManager {
  final List<Quiz> quizzes = [];
  final List<Participant> participants = [];

  // Helper method to get valid input
  String getInput(String prompt) {
    while (true) {
      stdout.write('$prompt: ');
      String? input = stdin.readLineSync()?.trim();
      if (input != null && input.isNotEmpty) return input;
      print('Invalid input. Please try again.');
    }
  }

  // Helper method to get valid integer input
  int getIntInput(String prompt, int min, int max) {
    while (true) {
      try {
        int value = int.parse(getInput(prompt));
        if (value >= min && value <= max) return value;
        print('Please enter a number between $min and $max');
      } catch (e) {
        print('Please enter a valid number');
      }
    }
  }

  void createQuiz() {
    String title = getInput('Enter quiz title');
    Quiz quiz = Quiz(title);
    
    while (true) {
      print('\nAdd question:');
      print('1. Single Choice Question');
      print('2. Multiple Choice Question');
      print('3. Finish adding questions');
      
      int choice = getIntInput('Enter your choice', 1, 3);
      if (choice == 3) break;

      String questionTitle = getInput('Enter question title');
      
      // Get options
      List<String> options = [];
      while (true) {
        String option = getInput('Enter option (or "done" to finish)');
        if (option.toLowerCase() == 'done') {
          if (options.length >= 2) break;
          print('Need at least 2 options!');
          continue;
        }
        options.add(option);
      }

      if (choice == 1) {
        print('\nAvailable options:');
        for (int i = 0; i < options.length; i++) {
          print('$i. ${options[i]}');
        }
        int correctAnswer = getIntInput(
          'Enter the correct answer number',
          0,
          options.length - 1
        );
        quiz.addQuestion(SingleChoiceQuestion(
          questionTitle,
          options,
          correctAnswer
        ));
      } else {
        List<int> correctAnswers = [];
        while (true) {
          print('\nCurrent correct answers: $correctAnswers');
          print('Available options:');
          for (int i = 0; i < options.length; i++) {
            print('$i. ${options[i]}');
          }
          print('Enter -1 when done');
          
          int answer = getIntInput(
            'Enter a correct answer number',
            -1,
            options.length - 1
          );
          if (answer == -1) {
            if (correctAnswers.length >= 2) break;
            print('Need at least 2 correct answers!');
            continue;
          }
          if (!correctAnswers.contains(answer)) {
            correctAnswers.add(answer);
          }
        }
        quiz.addQuestion(MultipleChoiceQuestion(
          questionTitle,
          options,
          correctAnswers
        ));
      }
      print('\nQuestion added successfully!');
    }
    
    quizzes.add(quiz);
    print('\nQuiz "${quiz.title}" created successfully!');
  }

  void registerParticipant() {
    String firstName = getInput('Enter first name');
    String lastName = getInput('Enter last name');
    try {
      participants.add(Participant(firstName, lastName));
      print('\nParticipant registered successfully!');
    } catch (e) {
      print('Error: $e');
    }
  }

  void takeQuiz() {
    if (quizzes.isEmpty) {
      print('No quizzes available. Please create a quiz first.');
      return;
    }
    if (participants.isEmpty) {
      print('No participants registered. Please register first.');
      return;
    }

    print('\nAvailable Quizzes:');
    for (int i = 0; i < quizzes.length; i++) {
      print('$i. ${quizzes[i].title}');
    }
    int quizIndex = getIntInput('Select quiz number', 0, quizzes.length - 1);
    Quiz selectedQuiz = quizzes[quizIndex];

    print('\nRegistered Participants:');
    for (int i = 0; i < participants.length; i++) {
      print('$i. ${participants[i].fullName}');
    }
    int participantIndex = getIntInput(
      'Select participant number',
      0,
      participants.length - 1
    );
    Participant selectedParticipant = participants[participantIndex];

    List<List<int>> answers = [];
    for (int i = 0; i < selectedQuiz.questions.length; i++) {
      Question question = selectedQuiz.questions[i];
      print('\nQuestion ${i + 1}: ${question.title}');
      print('Options:');
      for (int j = 0; j < question.options.length; j++) {
        print('$j. ${question.options[j]}');
      }

      if (question is SingleChoiceQuestion) {
        int answer = getIntInput(
          'Enter your answer',
          0,
          question.options.length - 1
        );
        answers.add([answer]);
      } else {
        List<int> multipleAnswers = [];
        while (true) {
          print('\nCurrent answers: $multipleAnswers');
          print('Enter -1 when done');
          int answer = getIntInput(
            'Enter an answer',
            -1,
            question.options.length - 1
          );
          if (answer == -1) break;
          if (!multipleAnswers.contains(answer)) {
            multipleAnswers.add(answer);
          }
        }
        answers.add(multipleAnswers);
      }
    }

    try {
      selectedQuiz.submitAnswers(selectedParticipant, answers);
      print('\nQuiz submitted successfully!');
    } catch (e) {
      print('Error submitting quiz: $e');
    }
  }

  void viewResults() {
    if (quizzes.isEmpty) {
      print('No quizzes available.');
      return;
    }

    print('\nAvailable Quizzes:');
    for (int i = 0; i < quizzes.length; i++) {
      print('$i. ${quizzes[i].title}');
    }
    int quizIndex = getIntInput('Select quiz number', 0, quizzes.length - 1);
    quizzes[quizIndex].displayResults();
  }

  void showMenu() {
    while (true) {
      print('\n=== Quiz Management System ===');
      print('1. Create New Quiz');
      print('2. Register Participant');
      print('3. Take Quiz');
      print('4. View Results');
      print('5. Exit');

      int choice = getIntInput('Enter your choice', 1, 5);

      switch (choice) {
        case 1:
          createQuiz();
          break;
        case 2:
          registerParticipant();
          break;
        case 3:
          takeQuiz();
          break;
        case 4:
          viewResults();
          break;
        case 5:
          print('Thank you for using the Quiz Management System!');
          return;
      }
    }
  }
}

void main() {
  QuizManager manager = QuizManager();
  print('Welcome to the Quiz Management System!');
  manager.showMenu();
}