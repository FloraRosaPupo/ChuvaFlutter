import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PalestrasPage extends StatefulWidget {
  final Map<String, dynamic> activityData;

  const PalestrasPage({Key? key, required this.activityData}) : super(key: key);

  @override
  State<PalestrasPage> createState() => _PalestrasPageState();
}

class _PalestrasPageState extends State<PalestrasPage> {
  bool _favorited = false;
  bool _loading = false;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Activity activity = Activity.fromJson(widget.activityData);

    DateTime startDateTime = DateTime.parse(activity.start);
    DateTime endDateTime = DateTime.parse(activity.end);

    String dayOfWeek = DateFormat('EEEE').format(startDateTime);
    String startTime = DateFormat('HH:mm').format(startDateTime);
    String endTime = DateFormat('HH:mm').format(endDateTime);

    String description = extractDescription(activity.description?['pt-br']);

    var cardColor = activity.category?['color'] != null
        ? fromCssColor(activity.category?['color'])
        : Colors.black;

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
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(color: cardColor),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${activity.category?['title']['pt-br']}',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    '${activity.title?['pt-br']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_outlined,
                        color: Colors.blue,
                        size: 17,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$dayOfWeek, $startTime - $endTime',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Row(children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 17,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: activity.locations!
                          .map<Widget>((locations) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${locations['title']['pt-br']}',
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: _loading ? Colors.grey : Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      onPressed: _loading
                          ? null
                          : () {
                              if (!_disposed) {
                                setState(() {
                                  _loading = true;
                                });

                                // Simulação de processo assíncrono
                                Future.delayed(Duration(seconds: 2), () {
                                  if (!_disposed) {
                                    setState(() {
                                      _favorited = !_favorited;
                                      _loading = false;
                                    });
                                  }
                                });
                              }
                            },
                      icon: _loading
                          ? Icon(Icons.cached)
                          : _favorited
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_outline),
                      label: _loading
                          ? Text('Processando...')
                          : Text(_favorited
                              ? 'Remover da sua agenda'
                              : 'Adicionar à sua agenda'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Palestrantes:',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (activity.people != null && activity.people!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: activity.people!.length,
                      itemBuilder: (context, index) {
                        var person = activity.people![index];
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go(
                                '/people?activity=${Uri.encodeComponent(jsonEncode(person))}');
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: CachedNetworkImage(
                                      imageUrl: person['picture'],
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${person['name']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 4),
                                      Text('${person['institution']}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String extractDescription(String htmlString) {
    RegExp regExp = RegExp(r'<p>(.*?)<\/p>');
    Iterable<RegExpMatch> matches = regExp.allMatches(htmlString);
    if (matches.isNotEmpty) {
      return matches.map((match) => match.group(1)!).join('\n\n');
    } else {
      return '';
    }
  }
}
