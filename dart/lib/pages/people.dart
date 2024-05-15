import 'dart:convert';

import 'package:chuva_dart/model/activity.dart';
import 'package:chuva_dart/services/activity_service.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';

class PeoplePage extends StatefulWidget {
  final Map<String, dynamic> person;

  const PeoplePage({Key? key, required this.person}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  List<Activity> activities = [];
  final ActivityService _activityService = ActivityService();

  void initState() {
    super.initState();
    fetchActivities();
  }

  void fetchActivities() async {
    List<Activity> fetchedActivities = await _activityService.fetchActivities();
    setState(() {
      activities = fetchedActivities;
    });
  }

  @override
  Widget build(BuildContext context) {
    String bio = extractBio(widget.person['bio']['pt-br']);

    List<Activity> personActivities = activities.where((activity) {
      List<Map<String, dynamic>>? people = activity.people;
      return people!.any((person) => person['id'] == widget.person['id']);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Chuva 💜 Flutter',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            GoRouter.of(context).canPop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.network(
                      widget.person['picture'] ??
                          'https://img2.gratispng.com/20180426/oaw/kisspng-computer-icons-avatar-symbol-clip-art-5ae226ac704125.7511328915247704764598.jpg',
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${widget.person['name']}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${widget.person['institution'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bio',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Text(
              bio,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              'Atividades',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Column(
              children: personActivities.map((activity) {
                DateTime startTime = DateTime.parse(activity.start);
                String location = activity.locations?[0]['title']['pt-br'];
                String author = activity.people?[0]['name'];

                var cardColor = activity.category != null &&
                        activity.category?['color'] != null
                    ? fromCssColor(activity.category?['color'])
                    : Colors.white;
                var backgroundColor = activity.category != null &&
                        activity.category?['background-color'] != null
                    ? fromCssColor(activity.category?['background-color'])
                    : Colors.white;
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go(
                      '/palestras?activity=${Uri.encodeComponent(jsonEncode(activity.toJson()))}',
                    );
                  },
                  child: Card(
                    color: backgroundColor,
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: cardColor, //A COR MUDA COM A DISCIPLINA
                            width: 3,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${startTime.hour}:${startTime.minute} - $location',
                            style: const TextStyle(fontSize: 10),
                          ),
                          Text(
                            activity.title?['pt-br'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(author),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String extractBio(String htmlString) {
    RegExp regExp = RegExp(r'<p>(.*?)<\/p>');
    Iterable<RegExpMatch> matches = regExp.allMatches(htmlString);
    if (matches.isNotEmpty) {
      return matches.map((match) => match.group(1)!).join('\n\n');
    } else {
      return '';
    }
  }
}
