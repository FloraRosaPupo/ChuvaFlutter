import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  final int id;
  final int changed;
  final String start;
  final String end;
  final Map<String, dynamic>? title;
  final Map<String, dynamic>? description;
  final Map<String, dynamic>? category;
  final List<Map<String, dynamic>>? locations;
  final Map<String, dynamic>? type;
  final List<Map<String, dynamic>>? papers;
  final List<Map<String, dynamic>>? people;
  final int status;
  final int weight;
  final dynamic addons;
  final dynamic parent;
  final String event;

  Activity({
    required this.id,
    required this.changed,
    required this.start,
    required this.end,
    required this.title,
    required this.description,
    required this.category,
    required this.locations,
    required this.type,
    required this.papers,
    required this.people,
    required this.status,
    required this.weight,
    required this.addons,
    required this.parent,
    required this.event,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int? ?? 0,
      changed: json['changed'] as int? ?? 0,
      start: json['start'] as String? ?? '',
      end: json['end'] as String? ?? '',
      title: json['title'] is String
          ? {'pt-br': json['title']}
          : json['title'] as Map<String, dynamic>?,
      description: json['description'] is String
          ? {'pt-br': json['description']}
          : json['description'] as Map<String, dynamic>?,
      category: json['category'] is String
          ? {'pt-br': json['category']}
          : json['category'] as Map<String, dynamic>?,
      locations:
          (json['locations'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
      type: json['type'] is String
          ? {'pt-br': json['type']}
          : json['type'] as Map<String, dynamic>?,
      papers: (json['papers'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
      people:
          (json['people'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
              [],
      status: json['status'] as int? ?? 0,
      weight: json['weight'] as int? ?? 0,
      addons: json['addons'],
      parent: json['parent'],
      event: json['event'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
