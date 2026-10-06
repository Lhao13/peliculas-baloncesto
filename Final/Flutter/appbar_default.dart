import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget {
  final String title;

  const AppBarDefault({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Image.asset(
            'assets/imagenes/pelota.png',
            height: 40,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
