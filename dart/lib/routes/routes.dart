import 'package:chuva_dart/pages/hompage.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/', //raiz
      builder: (context, state) => HomePage(),
    ), 
    GoRoute(
      path: '/', //raiz
      builder: (context, state) => HomePage(),
    ), 
  ],
);
