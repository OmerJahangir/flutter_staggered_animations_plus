import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations_plus_example/screens/card_column_screen.dart';
import 'package:flutter_staggered_animations_plus_example/screens/card_grid_screen.dart';
import 'package:flutter_staggered_animations_plus_example/screens/card_list_screen.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staggered Animations Plus Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StaggeredListDemo(),
    );
  }
}

class StaggeredListDemo extends StatelessWidget {
  const StaggeredListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('List Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardListScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Grid Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardGridScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Column Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardColumnScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
