import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Student {
  int id;
  String name;
  String address;
  int age;
  String contactNumber;

  Student({required this.id, required this.name,  required this.address,required this.age,  required this.contactNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'age': age,
      'contact_number': contactNumber,
    };
  }
}

Future<Database> database() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'student_database.db');
  return await openDatabase(path, version: 1, onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT, age INTEGER, contact_number TEXT)');
  });
}
Future<void> insertStudent(Student student) async {
  final db = await database();
  await db.insert(
    'students',
    student.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<int> insertStudentdb(Student student) async {
  final db = await database();
  return await db.insert(
    'students',
    student.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<Student>> getAllStudents() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('students');
  return List.generate(maps.length, (i) {
    return Student(
      id: maps[i]['id'],
      name: maps[i]['name'],
      address: maps[i]['address'],
      age: maps[i]['age'],
      contactNumber: maps[i]['contact_number'],
    );
  });
}

Future<int> updateStudent(Student student) async {
  final db = await database();
  return await db.update(
    'students',
    student.toMap(),
    where: 'id = ?',
    whereArgs: [student.id],
  );
}

