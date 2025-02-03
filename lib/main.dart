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

  final themeStrD = await rootBundle.loadString('assets/ThemeAlbumDark.json');
  final themeJsonD = jsonDecode(themeStrD);
  final themeD = ThemeDecoder.decodeThemeData(themeJsonD)!;

  runApp(MyApp(theme: theme, themeDark: themeD));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData themeDark;
  final themeController = ThemeController();

  MyApp({Key? key, required this.theme, required this.themeDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Album',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: themeDark,
          themeMode: themeMode,
          home: MyHomePage(title: 'Gestion des albums', themeController: themeController),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ThemeController themeController;

  MyHomePage({Key? key, required this.title, required this.themeController}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrincipal(
        title: widget.title,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () => setState(() => widget.themeController.toggleTheme()),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.red[400], // Fond rouge plus clair
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/vinyltransp.webp',
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Bienvenue sur l'application de gestion d'album",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                title: Text("News"),
                subtitle: Text("Dernières actualités"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Version 1 en cours de développement"),
                subtitle: Text("Wait and see"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(CustomIcons.home), label: "Accueil"),
          NavigationDestination(icon: Icon(CustomIcons.note_beamed), label: "Page suivante"),
          NavigationDestination(icon: Icon(CustomIcons.settings), label: "Paramètres"),
        ],
      ),
    );
  }
}
