import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tb2/model/student.dart';
import 'package:tb2/utils/update.dart';
import 'package:tb2/utils/add.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F50B5),
        title: Text('Student List'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Student>('students').listenable(),
          builder: (context, Box<Student> box, _) {
            int totalStudents = box.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Total Student: $totalStudents; Total Subject: 0',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: totalStudents > 0
                        ? buildStudentList(box)
                        : Text('List empty'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CreateStudentDialog(),
          );
        },
        child: Icon(Icons.person_add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Widget buildStudentList(Box<Student> box) {
    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) {
        Student student = box.getAt(index)!;
        return Container(
          width: double.maxFinite,
          height: 110.0,
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(7.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: student.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 20
                    ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, size: 20.0,color: Colors.black54),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => UpdateStudentDialog(student: student),
                          );
                        },
                      ),
                      SizedBox(width: 0),
                      IconButton(
                        icon: Icon(Icons.delete, size: 20.0,color: Colors.black54),
                        onPressed: () {
                          showDeleteDialog(context, index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 0),


              RichText(
                text: TextSpan(
                  text: 'NIM     ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(
                      text: student.nim,
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Email  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(
                      text: student.email,
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Phone ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(
                      text: student.phone,
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  int calculateTotalSubjects(Box<Student> box) {
    int TotalSubjects = 0;
    for (int i = 0; i < box.length; i++) {
    }
    return TotalSubjects;
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'NO',
              style: TextStyle(color: Colors.pink),
            ),
          ),
          TextButton(
            onPressed: () {
              Hive.box<Student>('students').deleteAt(index);
              Navigator.pop(context);
            },
            child: Text(
              'YES',
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ],
      ),
    );
  }
}
