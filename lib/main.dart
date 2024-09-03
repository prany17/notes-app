import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/models/note_database.dart';
import 'package:todo_practice/pages/home_page.dart';
import 'package:todo_practice/theme/theme_provider.dart';

void main() async {
  // initialize the note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    MultiProvider(
      providers: [
        // note db provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        // theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).newTheme,
    );
  }
}
