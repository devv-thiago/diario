import 'package:diario/widget/calendario.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceSize = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white),
        height: deviceSize.size.height,
        width: deviceSize.size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Calendario(
            height: deviceSize.size.height * 0.4,
            width: deviceSize.size.width * 0.95,
          ),
        ]),
      ),
    );
  }
}
