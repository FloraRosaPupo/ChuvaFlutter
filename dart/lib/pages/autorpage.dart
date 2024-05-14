import 'package:flutter/material.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class AuthorPage extends StatelessWidget {
  final Map<String, dynamic> activityData;

  const AuthorPage({Key? key, required this.activityData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Activity activity = Activity.fromJson(activityData);

    var speakers = activity.people;

    if (speakers == null || speakers.isEmpty) {
      // Se não houver palestrantes, exiba uma mensagem
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
            onPressed: () => GoRouter.of(context).pop(),
          ),
        ),
        body: Center(
          child: Text('Nenhum palestrante encontrado'),
        ),
      );
    }

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
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: speakers.length,
        itemBuilder: (context, index) {
          var speaker = speakers[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(speaker['picture']),
              ),
              title: Text(speaker['name'] ?? 'Nome não especificado'),
              subtitle: Text(
                  speaker['institution'] ?? 'Instituição não especificada'),
            ),
          );
        },
      ),
    );
  }
}
