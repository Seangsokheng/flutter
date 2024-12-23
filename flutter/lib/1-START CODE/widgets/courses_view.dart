import 'package:flutter/material.dart';
import 'package:week3/1-START%20CODE/data/courseData.dart';
import 'package:week3/1-START%20CODE/models/course.dart';
import 'package:week3/1-START%20CODE/widgets/course_view.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (courseItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: courseItem.length,
        itemBuilder: (ctx, index) => CourseTile(
          courses: courseItem[index],
          index: index,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socre App'),
      ),
      body: content,
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({required this.courses, required this.index, super.key});

  final Course courses;
  final int index;
  
  void avgCal() {
    courses.studentSocres!.map((item) => {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No sorce'));

    if (courses.studentSocres!.isNotEmpty) {
      content = Column(
        children: [
          Row(
            children: [
              Text("socre ${courses.studentSocres?.length}" ),
              const Text("socre"),
            ],
          ),
          Text("avg"),
        ],
      );
    }

    return ListTile(
        title: Text(courses.name),
        leading: content,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseView(
                      course: courses,
                    )),
          );
        });
  }
}
