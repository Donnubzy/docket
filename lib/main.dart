
import 'package:docket/data/repo/notes_db.dart';
import 'package:docket/presentation/screens/notes_home.dart';
import 'package:docket/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDatabase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NotesDatabase()),
          ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Docket App',
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: const NotesHome(),
          );
        },
    );
  }
}

