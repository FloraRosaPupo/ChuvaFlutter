import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:chuva_dart/model/activity.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:chuva_dart/model/activity.dart';

class ActivityService {
  Future<List<Activity>> fetchActivities() async {
    try {
      String data = await rootBundle.loadString('assets/activities.json');
      List<dynamic> jsonData = json.decode(data)['data'];
      List<Activity> activities =
          jsonData.map((json) => Activity.fromJson(json)).toList();
      return activities;
    } catch (e) {
      print('Erro ao carregar atividades: $e');
      return [];
    }
  }


  Future<Activity?> fetchActivityById(String id) async {
    try {
      String data = await rootBundle.loadString('assets/activities.json');
      List<dynamic> jsonData = json.decode(data)['data'];
      var activityJson = jsonData.firstWhere((element) => element['id'] == id,
          orElse: () => null);
      if (activityJson != null) {
        return Activity.fromJson(activityJson);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao carregar atividade por ID: $e');
      return null;
    }
  }
}
