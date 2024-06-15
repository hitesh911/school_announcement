// providers/announcement_provider.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_announcement/models/announcement.dart';

class AnnouncementProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Announcement>> get announcements {
    return _db
        .collection('announcements')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Announcement.fromFirestore(doc))
          .toList();
    });
  }
}
