import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditCourse extends StatefulWidget {
  final String id, courseInstructor, courseCredits, courseID, courseName, dateEntered;

  final CourseApi api = CourseApi();
  final StudentApi api2 = StudentApi();

  EditCourse(this.id, this.courseInstructor, this.courseCredits, this.courseID, this.courseName, this.dateEntered);

  @override
  _EditCourseState createState() => _EditCourseState(id, courseInstructor, courseCredits, courseID, courseName, dateEntered);
}

class _EditCourseState extends State<EditCourse> {
  final String id, courseInstructor, courseCredits, courseID, courseName, dateEntered;

  _EditCourseState(this.id, this.courseInstructor, this.courseCredits, this.courseID, this.courseName, this.dateEntered);

  List student = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api2.getAllStudents().then((data){
      setState(() {
        student = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.courseName,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: _dbLoaded ? Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: [
                  ...student
                    .map<Widget>(
                      (student) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                child: Text(student['studentID']),
                              ),
                              title: Text(
                                (student['fname'] +
                                " " +
                                student['lname']),
                                style: TextStyle(fontSize: 20),
                              ),
                              ), 
                            ] 
                          ),
                        ),
                    )
                  .toList(),
                ]),
            ),
          ],
        ) :
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style: 
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
      )
      ),
      floatingActionButton:
        FloatingActionButton(child: Icon(Icons.home), onPressed: () =>{
          Navigator.pop(context),
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage())),
        }),
    );
  }
}