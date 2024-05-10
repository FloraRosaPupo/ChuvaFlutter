import 'package:chuva_dart/pages/atividadespage.dart';
import 'package:chuva_dart/pages/atvcoordenadores.dart';
import 'package:chuva_dart/pages/autorpage.dart';
import 'package:chuva_dart/pages/hompage.dart';
import 'package:chuva_dart/pages/palestraspage.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  //testes
  //initialLocation: '/atividades',
  routes: [
    GoRoute(
      path: '/', //raiz do projeto
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/palestras',
      builder: (context, state) => Palestras(),
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
