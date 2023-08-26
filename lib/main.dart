import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // ↓ Add this.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {           // ← 1
    var appState = context.watch<MyAppState>();  // ← 2
    var pair = appState.current;                 // ← Add this.
    return Scaffold(                             // ← 3
      body: Column(                              // ← 4
        children: [
          // Text('A random AWESOME idea:'),        // ← 5
          Text(pair.asLowerCase),                // ← Change to this.
          BigCard(appState: appState),    // ← 6
          ElevatedButton(
            onPressed: () {
              appState.getNext();  // ← This instead of print().
            },
            child: Text('Next'),
          ),
        ],                                       // ← 7
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);       // ← Add this. 
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(appState.current.asLowerCase),
    );
  }
}