import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:chuva_dart/services/activity_service.dart';
import 'package:from_css_color/from_css_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Activity> activities = [];
  final ActivityService _activityService = ActivityService();
  int? selectedDay;

  @override
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
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
            Icons.autorenew_rounded,
            color: Colors.white,
          ),
          onPressed: fetchActivities,
        ),
      ),
      body: Column(
        children: [
          // Seção de cabeçalho
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Programação',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.calendar_month,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 50),
                        const Text('Exibindo todas as atividades'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Seção de seleção de dias
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDay = null;
                        fetchActivities();
                      });
                    },
                    child: Column(
                      children: const [
                        Text(
                          'Nov',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2023',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                for (var i = 26; i <= 30; i++)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDay = i;
                        loadActivitiesForSelectedDays(i);
                      });
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) {
                        return i == selectedDay
                            ? Colors.transparent
                            : Colors.white.withOpacity(0.3);
                      }),
                    ),
                    child: Text(
                      '$i',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: selectedDay == i
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Lista de atividades
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                var activity = activities[index];
                var startTime = DateTime.tryParse(activity.start ?? '');
                var endTime = DateTime.tryParse(activity.end ?? '');

                if (startTime == null || endTime == null) {
                  return SizedBox
                      .shrink(); // Se não conseguirmos parsear o tempo, retornamos um widget vazio
                }

                var location = activity.locations?.isNotEmpty == true
                    ? activity.locations![0]['title']['pt-br'] ??
                        'Local não especificado'
                    : 'Local não especificado';

                var title = activity.title != null && activity.title!.isNotEmpty
                    ? activity.title!['pt-br'] ?? 'Título não especificado'
                    : 'Título não especificado';

                var author = activity.people?.isNotEmpty == true
                    ? activity.people![0]['name'] ?? 'Autor não especificado'
                    : 'Autor não especificado';

                var backgroundColor = activity.category != null &&
                        activity.category?['background-color'] != null
                    ? fromCssColor(activity.category?['background-color'])
                    : Colors.white;
                var cardColor = activity.category != null &&
                        activity.category?['color'] != null
                    ? fromCssColor(activity.category?['color'])
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
                            title,
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void loadActivitiesForSelectedDays(int? day) async {
    if (day == null) {
      fetchActivities();
    } else {
      var fetchedActivities = await _activityService.fetchActivities(day: day);
      setState(() {
        activities = fetchedActivities;
      });
    }
  }
}
