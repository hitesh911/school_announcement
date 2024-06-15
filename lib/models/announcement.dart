// models/announcement.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String title;
  final String des;
  final Timestamp date;
  final String img;

  Announcement(
      {required this.title,
      required this.des,
      required this.date,
      required this.img});

  factory Announcement.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Announcement(
      title: data['title'] ?? '',
      des: data['des'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      img: data['img'] ?? '',
    );
  }
}
