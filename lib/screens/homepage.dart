import 'package:flutter/material.dart';
import 'package:diario/widget/anotacao.dart';
import 'package:diario/widget/calendario.dart';
import 'package:diario/controller/anotacao.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime? selectedDay;


  @override
  Widget build(BuildContext context) {
    AnotacaoController anotacaoController =
        Provider.of<AnotacaoController>(context, listen: false);
    MediaQueryData deviceSize = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        height: deviceSize.size.height,
        width: deviceSize.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Calendario(
              height: deviceSize.size.height * 0.4,
              width: deviceSize.size.width * 0.95,
              onDaySelected: (day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),
            // Expanded(
            //   child: Anotacao(
            //     height: deviceSize.size.height * 0.7,
            //     width: deviceSize.size.width * 0.95,
            //     anotacoes: anotacaoController.anotacoes,
            //     selectedDay: selectedDay ?? DateTime.now(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
