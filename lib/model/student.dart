// lib/model/student.dart
import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId:1)
class Student {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String nim;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String email;


  Student({
    required this.name,
    required this.nim,
    required this.phone,
    required this.email,
  });
}