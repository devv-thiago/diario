import 'package:diario/widget/anotacao.dart';
import 'package:diario/widget/calendario.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> _anotacoes = [];

  void _updateAnotacoes(List<Map<String, dynamic>> anotacoes) {
    setState(() {
      _anotacoes = anotacoes;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceSize = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white),
        height: deviceSize.size.height,
        width: deviceSize.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Calendario(
              height: deviceSize.size.height * 0.4,
              width: deviceSize.size.width * 0.95,
              onDateSelected: (anotacoes) {
                _updateAnotacoes(anotacoes);
              },
            ),
            if (_anotacoes.isNotEmpty)
              Anotacao(
                height: deviceSize.size.height * 0.5,
                width: deviceSize.size.width * 0.95,
                anotacoes: _anotacoes,
              ),
          ],
        ),
      ),
    );
  }
}
