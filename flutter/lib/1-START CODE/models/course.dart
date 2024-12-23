class Course {
  final String name;
  List<Studentsocre>? studentSocres = [];

  void addStudentSocre(Studentsocre studentSocre) {
    studentSocres!.add(studentSocre);
  }

  Course({required this.name, this.studentSocres});
}

class Studentsocre {
  final String name;
  final double socre;

  Studentsocre({required this.name, required this.socre});
}
