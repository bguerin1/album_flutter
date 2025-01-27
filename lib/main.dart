import 'package:flutter/material.dart';
import 'package:album_flutter/AppBar/appbar.dart';
import 'package:album_flutter/CustomIcons.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:album_flutter/ThemeController.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/ThemeAlbum.json');

  final themeJson = jsonDecode(themeStr);

  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  // Dark

  final themeStrD = await rootBundle.loadString('assets/ThemeAlbumDark.json');

  final themeJsonD = jsonDecode(themeStrD);

  final themeD = ThemeDecoder.decodeThemeData(themeJsonD)!;


  runApp(MyApp(theme : theme, themeDark : themeD));
}


class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData themeDark;
  final themeController = ThemeController();

  MyApp({Key? key, required this.theme, required this.themeDark}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode> (
      valueListenable: themeController,
      builder: (context,themeMode, _) {

        return MaterialApp(
          title: 'Album',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme : themeDark,
          home: const MyHomePage(title: 'Album'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int currentPageIndex = 1;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBarPrincipal(
        title: "Gestion des albums",
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(CustomIcons.home) ,
            label: "Accueil",
          ),
          NavigationDestination(
            icon: Icon(CustomIcons.note_beamed),
            label: "Page suivante",
          ),
          NavigationDestination(
            icon: Icon(CustomIcons.settings),
            label: "Paramètres",
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
