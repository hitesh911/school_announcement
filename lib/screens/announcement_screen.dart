// screens/announcement_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_announcement/providers/announcement_provider.dart';
import 'package:school_announcement/models/announcement.dart';
import 'package:intl/intl.dart';

class AnnouncementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Announcements'),
      ),
      body: StreamProvider<List<Announcement>>.value(
        value: AnnouncementProvider().announcements,
        initialData: [],
        child: Consumer<List<Announcement>>(
          builder: (context, announcements, child) {
            if (announcements.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  var announcement = announcements[index];
                  return AnnouncementCard(announcement: announcement);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class AnnouncementCard extends StatefulWidget {
  final Announcement announcement;

  AnnouncementCard({required this.announcement});

  @override
  _AnnouncementCardState createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.announcement.img,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.announcement.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  DateFormat.yMMMd().format(widget.announcement.date.toDate()),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 7),
                if (_showDescription) Text(widget.announcement.des),
                SizedBox(height: 3),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showDescription = !_showDescription;
                      print(_showDescription
                          ? 'Showing description for: ${widget.announcement.title}'
                          : 'Hiding description for: ${widget.announcement.title}');
                    });
                  },
                  child: Text(
                    _showDescription ? 'Show Less' : 'Show More',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
