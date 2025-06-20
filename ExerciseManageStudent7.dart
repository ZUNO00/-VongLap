import 'dart:io';

class Student {
  String name;
  double math;
  double physics;
  double chemistry;

  Student(this.name, this.math, this.physics, this.chemistry);

  double get average => (math + physics + chemistry) / 3;

  String get rank {
    if (average < 5) return "Kém";
    if (average < 7) return "Khá";
    if (average < 9) return "Giỏi";
    return "Xuất sắc";
  }
}

void main() {
  List<Student> students = [];

  while (true) {
    print("\n=== QUẢN LÝ SINH VIÊN ===");
    print("1. Thêm sinh viên");
    print("2. Hiển thị danh sách sinh viên");
    print("3. Tìm sinh viên có ĐTB cao nhất");
    print("4. Thoát");
    stdout.write("Chọn chức năng (1-4): ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addStudent(students);
        break;
      case '2':
        showStudents(students);
        break;
      case '3':
        findTopStudent(students);
        break;
      case '4':
        print("Đã thoát chương trình.");
        return;
      default:
        print("Lựa chọn không hợp lệ.");
    }
  }
}

void addStudent(List<Student> list) {
  stdout.write("Nhập họ tên sinh viên: ");
  String name = stdin.readLineSync() ?? "";

  double math = readScore("Toán");
  double physics = readScore("Lý");
  double chemistry = readScore("Hóa");

  list.add(Student(name, math, physics, chemistry));
  print("✅ Đã thêm sinh viên $name");
}

double readScore(String subject) {
  while (true) {
    stdout.write("Nhập điểm $subject: ");
    try {
      double score = double.parse(stdin.readLineSync()!);
      if (score < 0 || score > 10) throw FormatException();
      return score;
    } catch (_) {
      print("❌ Điểm không hợp lệ. Vui lòng nhập số từ 0 đến 10.");
    }
  }
}

void showStudents(List<Student> list) {
  if (list.isEmpty) {
    print("📭 Danh sách sinh viên trống.");
    return;
  }

  print("\n📋 DANH SÁCH SINH VIÊN:");
  print(
      "| Họ tên               | Toán | Lý   | Hóa  | ĐTB   | Xếp loại     |");
  print("-------------------------------------------------------------------------");

  for (var s in list) {
    print(
        "| ${s.name.padRight(20)} | ${s.math.toStringAsFixed(1).padLeft(4)} | ${s.physics.toStringAsFixed(1).padLeft(4)} | ${s.chemistry.toStringAsFixed(1).padLeft(4)} | ${s.average.toStringAsFixed(2).padLeft(5)} | ${s.rank.padRight(12)} |");
  }
}

void findTopStudent(List<Student> list) {
  if (list.isEmpty) {
    print("⚠️ Danh sách sinh viên trống.");
    return;
  }

  var topStudent = list.reduce((a, b) => a.average > b.average ? a : b);

  print("\n🏆 SINH VIÊN CÓ ĐTB CAO NHẤT:");
  print("Họ tên: ${topStudent.name}");
  print("Điểm Toán: ${topStudent.math}");
  print("Điểm Lý: ${topStudent.physics}");
  print("Điểm Hóa: ${topStudent.chemistry}");
  print("ĐTB: ${topStudent.average.toStringAsFixed(2)}");
  print("Xếp loại: ${topStudent.rank}");
}
