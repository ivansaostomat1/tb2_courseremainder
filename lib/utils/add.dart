import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tb2/model/student.dart';

class CreateStudentDialog extends StatefulWidget {
  @override
  _CreateStudentDialogState createState() => _CreateStudentDialogState();
}

class _CreateStudentDialogState extends State<CreateStudentDialog> {
  late TextEditingController nameController;
  late TextEditingController nimController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nimController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Student',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.0),
              _buildTextField('Name', TextInputType.text),
              _buildTextField('NIM', TextInputType.number),
              _buildTextField('Phone', TextInputType.phone),
              _buildTextField('Email', TextInputType.emailAddress),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(child: _buildCreateButton()),
                  SizedBox(width: 8.0),
                  Expanded(child: _buildCancelButton()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: TextField(
        controller: label == 'Name'
            ? nameController
            : label == 'NIM'
                ? nimController
                : label == 'Phone'
                    ? phoneController
                    : emailController,
        decoration: InputDecoration(
          labelText: label,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.only(bottom: 5.0),
        ),
        keyboardType: inputType,
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: () {
        createStudent();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
      ),
      child: Text(
        'CREATE',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
      ),
      child: Text(
        'CANCEL',
        style: TextStyle(color: Colors.black),
      ),
    );
  }



  void createStudent() {
    final box = Hive.box<Student>('students');
    box.add(Student(
      name: nameController.text,
      nim: nimController.text,
      phone: phoneController.text,
      email: emailController.text,
    ));
  }
}
