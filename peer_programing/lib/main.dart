import 'package:flutter/material.dart';
import 'routes.dart';
import 'src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peer learning',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.initialRoute,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}