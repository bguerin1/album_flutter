import 'package:flutter/material.dart';


class AppBarPrincipal extends StatefulWidget implements PreferredSizeWidget{
  const AppBarPrincipal({super.key});

  String title = "Album";
  late List<Widget> widgets ;

  @override
  State<AppBarPrincipal> createState() => AppBarPrincipal();

  @override
  Size get prefferedSize => Size.fromHeight(kToolbarHeight);

}

class AppBarPrincipalState extends State<AppBarPrincipal> {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: (){
          },
        ),
      ],
    );
  }

}

