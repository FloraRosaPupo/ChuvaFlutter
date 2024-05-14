import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:chuva_dart/model/activity.dart';

class ActivityService {
  Future<List<Activity>> fetchActivities({int? day}) async {
    try {
      String data = await rootBundle.loadString('assets/activities.json');
      List<dynamic> jsonData = json.decode(data)['data'];
      List<Activity> activities =
          jsonData.map((json) => Activity.fromJson(json)).toList();

      if (day != null) {
        return activities.where((activity) {
          var startDate = DateTime.tryParse(activity.start);
          return startDate != null && startDate.day == day;
        }).toList();
      } else {
        return activities;
      }
    } catch (e) {
      print('Erro ao carregar atividades: $e');
      return [];
    }
  }
}
