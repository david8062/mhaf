import 'package:flutter/material.dart';
class Drawe extends StatefulWidget {
  const Drawe({super.key});

  @override
  State<Drawe> createState() => _DraweState();
}

class _DraweState extends State<Drawe> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
     backgroundColor: const Color.fromRGBO(233, 52, 52, 0.867),
     child: Column(
      children: [
        SizedBox(
          width: 150.0,
          height: 150.0,
          child: Image.asset("assets/logos/logo_main.png"),
        )
      ],
     )
    );
  }
}