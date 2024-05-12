import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:chuva_dart/pages/atividadespage.dart';
import 'package:chuva_dart/pages/atvcoordenadores.dart';
import 'package:chuva_dart/pages/autorpage.dart';
import 'package:chuva_dart/pages/hompage.dart';
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

        if (activityData != null) {
          return PalestrasPage(activityData: jsonDecode(activityData));
        }

        return Scaffold(
          body: Center(
            child: Text(
              'Erro: Dados da atividade não encontrados na rota de palestras.',
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/autor',
      builder: (context, state) => AuthorPage(),
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
