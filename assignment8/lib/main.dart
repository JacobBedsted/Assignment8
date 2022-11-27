import 'package:flutter/material.dart';
import 'api.dart';
import 'editCourse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CourseApi api = CourseApi();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api.getAllCourses().then((data){
      setState(() {
        courses = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course List Application"),
      ),
      body: Center(
        child: _dbLoaded ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...courses
                                .map<Widget>(
                                  (courses) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditCourse(
                                                    courses['_id'],
                                                    courses['courseInstructor'],
                                                    courses['courseCredits'].toString(),
                                                    courses['courseID'],
                                                    courses['courseName'],
                                                    courses['dateEntered']))),
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          child: Text(courses['courseName']),
                                        ),
                                        title: Text(
                                          (courses['courseInstructor'] +
                                              "    Credits: " +
                                              courses['courseCredits'].toString()),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
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
    );
  }
}
