import 'package:flutter/material.dart';
import 'package:tb2/model/student.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final Box contactBox;
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentFormKey = GlobalKey<FormState>();

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    contactBox = Hive.box('student_db');
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  void _clearTextFields() {
    _nameController.clear();
    _nimController.clear();
    _phoneController.clear();
    _emailController.clear();
  }


  _addInfo() async {
    if (_studentFormKey.currentState!.validate()) {
      Student newStudent = Student(
        name: _nameController.text,
        nim: _nimController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );

      contactBox.add(newStudent);
      print('Info added to box!');
      Navigator.of(context).pop();
    }
  }

  _deleteInfo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this student?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL',style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                contactBox.deleteAt(index);
                print('Item deleted from box at index: $index');
                Navigator.of(context).pop();
              },
              child: Text('DELETE', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  _updateInfo() {
    if (_studentFormKey.currentState!.validate()) {
      if (selectedIndex != -1) {
        Student newStudent = Student(
          name: _nameController.text,
          nim: _nimController.text,
          phone: _phoneController.text,
          email: _emailController.text,
        );

        contactBox.putAt(selectedIndex, newStudent);
        print('Info updated in box at index: $selectedIndex');

        Navigator.of(context).pop();
        setState(() {
          selectedIndex = -1;
        });
      }
    }
  }

  // EDIT FORM
  AlertDialog buildEditStudentDialog(int index, Student studentData) {
    _nameController.text = studentData.name;
    _nimController.text = studentData.nim;
    _phoneController.text = studentData.phone;
    _emailController.text = studentData.email;

    return AlertDialog(
      title: Text('Update Student Information'),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      content: Container(
        width: 500,
        height: 240,
        child: Form(
          key: _studentFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Student Name',
                  contentPadding: EdgeInsets.zero,
                ),
                controller: _nameController,
                validator: _fieldValidator,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'NIM',
                  contentPadding: EdgeInsets.zero,
                ),
                controller: _nimController,
                validator: _fieldValidator,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                  contentPadding: EdgeInsets.zero,
                ),
                controller: _phoneController,
                validator: _fieldValidator,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.zero,
                ),
                controller: _emailController,
                validator: _fieldValidator,
                keyboardType: TextInputType.emailAddress,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 65,
                    child: ElevatedButton(
                      onPressed: _updateInfo,
                      child: Text(
                        'UPDATE',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white60,
                      ),
                    ),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    flex: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
            ],
          ),
        ),
      ),
    );
  }

  // ADD FORM
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clearTextFields();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create Student'),
                content: Container(
                  width: 500.0,
                  height: 240.0,
                  child: Center(
                    child: Form(
                      key: _studentFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Student Name',
                              contentPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            controller: _nameController,
                            validator: _fieldValidator,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'NIM',
                              contentPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            controller: _nimController,
                            validator: _fieldValidator,
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              contentPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            controller: _phoneController,
                            validator: _fieldValidator,
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              contentPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            controller: _emailController,
                            validator: _fieldValidator,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _addInfo,
                                  child: Text(
                                    'CREATE',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white60,
                                  ),
                                ),
                              ),
                              SizedBox(width: 9),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white60,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.pink,
        child: Icon(Icons.person_add, color: Colors.white),
      ),

      body: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10 ,bottom: 40.0),
              child: Text(
                'Total students: ${contactBox.length}      Total subjects: 0',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: contactBox.listenable(),
                builder: (context, Box box, widget) {
                  if (box.isEmpty) {
                    return Center(
                      child: Text('List Is Empty !'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        var currentBox = box;
                        var studentData = currentBox.getAt(index)!;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        studentData.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'NIM ',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(studentData.nim),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Email ',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(studentData.email),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Phone ',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(studentData.phone),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return buildEditStudentDialog(index, studentData);
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deleteInfo(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
