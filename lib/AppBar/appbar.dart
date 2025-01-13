import 'package:flutter/material.dart';

class AppBarPrincipal extends StatefulWidget implements PreferredSizeWidget {
  const AppBarPrincipal({super.key, required this.title, required this.actions});

  final String title; // Titre de l'AppBar
  final List<Widget> actions; // Liste des actions à afficher dans l'AppBar


  @override
  State<AppBarPrincipal> createState() => AppBarPrincipalState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarPrincipalState extends State<AppBarPrincipal> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title, style: TextStyle(color: Colors.white)),
      actions: widget.actions,
      backgroundColor: Colors.green,
    );
  }
}
