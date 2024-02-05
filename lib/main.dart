import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:yatch_project/ui/game.dart";
import "package:yatch_project/ui/total.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp.router(
      routerConfig: router, debugShowCheckedModeBanner: false));
}

final router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const GamePage()),
  GoRoute(
      path: "/total",
      builder: (context, state) => TotalPage(total: state.extra as int))
]);
