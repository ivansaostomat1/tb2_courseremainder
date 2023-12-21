// lib/main.dart
import 'package:flutter/material.dart';
import 'package:tb2/model/student.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/info_screens.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox('student_db');
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Remainder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: InfoScreen(),
    );
  }
}