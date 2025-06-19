// lib/models/body_part.dart

class BodyPart {
  final String name;
  final String imagePath;
  final String description;

  BodyPart({
    required this.name,
    required this.imagePath,
    required this.description,
  });

  // สามารถเพิ่มวิธีการสร้าง BodyPart จากข้อมูล JSON ได้ถ้าจำเป็น
  // factory BodyPart.fromJson(Map<String, dynamic> json) {
  //   return BodyPart(
  //     name: json['name'],
  //     imagePath: json['imagePath'],
  //     description: json['description'],
  //   );
  // }
}
