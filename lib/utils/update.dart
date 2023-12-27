import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tb2/model/student.dart';
import 'package:tb2/utils/add.dart';

class UpdateStudentDialog extends StatefulWidget {
  final Student student;

  const UpdateStudentDialog({required this.student});

  @override
  _UpdateStudentDialogState createState() => _UpdateStudentDialogState();
}

class _UpdateStudentDialogState extends State<UpdateStudentDialog> {
  late TextEditingController nameController;
  late TextEditingController nimController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    nimController = TextEditingController(text: widget.student.nim);
    phoneController = TextEditingController(text: widget.student.phone);
    emailController = TextEditingController(text: widget.student.email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 5),
      title: Text('Update Student Information', style: TextStyle(color: Colors.black)),
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
              ),
              SizedBox(height: 0), // Add spacing
              TextField(
                controller: nimController,
              ),
              SizedBox(height: 0), // Add spacing
              TextField(
                controller: phoneController,
              ),
              SizedBox(height: 0), // Add spacing
              TextField(
                controller: emailController,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {
                    updateStudent();
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: ElevatedButton(
                  onPressed: () {
                    updateStudent();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void updateStudent() async {
    final box = Hive.box<Student>('students');
    final index = box.values.toList().indexWhere((element) => element == widget.student);

    await box.putAt(
      index,
      Student(
        name: nameController.text,
        nim: nimController.text,
        phone: phoneController.text,
        email: emailController.text,
      ),
    );
  }
}
