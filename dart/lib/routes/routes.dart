import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:chuva_dart/pages/atividadespage.dart';
import 'package:chuva_dart/pages/atvcoordenadores.dart';
import 'package:chuva_dart/pages/people.dart';
import 'package:chuva_dart/pages/homepage.dart';
import 'package:chuva_dart/pages/palestraspage.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Raiz do projeto
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/palestras',
      builder: (context, state) {
        final uri = state.uri;
        final queryParameters = uri.queryParameters;
        final activityData = queryParameters['activity'];

        try {
          if (activityData != null) {
            return PalestrasPage(activityData: jsonDecode(activityData));
          }
        } catch (e) {
          print('Erro ao decodificar os dados da atividade: $e');
        }

        return ErrorPage(
            message:
                'Dados da atividade não encontrados na rota de palestras.');
      },
    ),
    GoRoute(
      path: '/people',
      builder: (context, state) {
        final uri = state.uri;
        final queryParameters = uri.queryParameters;
        final activityData = queryParameters['activity'];

        if (activityData != null) {
          return PeoplePage(person: jsonDecode(activityData));
        }

        return Scaffold(
          body: Center(
            child: Text(
              'Erro: Dados da pessoa não encontrados na rota.',
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/atividades',
      builder: (context, state) => Atividades(),
    ),
    GoRoute(
      path: '/atividades-coord',
      builder: (context, state) => PalestrasCoordenadores(),
    ),
  ],
);

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}
