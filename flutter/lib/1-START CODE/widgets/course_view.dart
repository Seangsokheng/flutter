import 'package:flutter/material.dart';
import 'package:week3/1-START%20CODE/models/course.dart';
import 'package:week3/1-START%20CODE/widgets/score_form.dart';

class CourseView extends StatefulWidget {
  const CourseView({required this.course, super.key});

  final Course course;

  @override
  State<CourseView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CourseView> {
  Future<void> _addItem(BuildContext context) async {
    final Studentsocre? result = await Navigator.push<Studentsocre>(
      context,
      MaterialPageRoute(builder: (context) => const ScoreForm()),
    );
    if (result != null) {
      setState(() {
        widget.course.studentSocres!.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (widget.course.studentSocres!.isNotEmpty) {
      content = ListView(
        children: [
          ...widget.course.studentSocres!
              .map((item) => Row(
                    children: [
                      Text(item.name),
                      Text(item.socre as String),
                    ],
                  ))
              .toList(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
