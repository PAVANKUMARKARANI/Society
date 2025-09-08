import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:society/home_page.dart';
import 'graphql_config.dart';

void main() async {
  await initHiveForFlutter(); // Required for cache storage

  runApp(GraphQLProvider(client: GraphQLConfig.client, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Society', home: HomePage());
  }
}
