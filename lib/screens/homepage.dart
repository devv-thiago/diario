import 'package:diario/controller/anotacao.dart';
import 'package:diario/widget/anotacao.dart';
import 'package:flutter/material.dart';
import 'package:diario/widget/calendario.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime selectedDay = DateTime.now();
  late List<DateTime> datasAnotacoes;
  late AnotacaoController anotacaoController;

  @override
  void initState() {
    anotacaoController = AnotacaoController();
    datasAnotacoes = anotacaoController.listarDatasComAnotacoes();
    debugPrint("$datasAnotacoes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceSize = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 100),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        height: deviceSize.size.height,
        width: deviceSize.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Calendario(
              height: deviceSize.size.height * 0.40,
              width: deviceSize.size.width * 0.90,
              onDaySelected: (day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (dragDetail) {
                  if (dragDetail.velocity.pixelsPerSecond.dx < 1) {
                    setState(() {
                      for (var data in datasAnotacoes) {
                        debugPrint("$data");
                      }
                      selectedDay = selectedDay.add(const Duration(days: 1));
                      debugPrint("$selectedDay");
                    });
                  } else {
                    setState(() {
                      selectedDay =
                          selectedDay.subtract(const Duration(days: 1));
                      debugPrint("$selectedDay");
                    });
                  }
                },
                child: Anotacao(
                  height: deviceSize.size.height * 0.60,
                  width: deviceSize.size.width,
                  selectedDay: selectedDay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
