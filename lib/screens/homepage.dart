import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/material.dart';
import 'package:diario/widget/anotacao.dart';
import 'package:diario/widget/calendario.dart';
import 'package:diario/controller/anotacao_controller.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnotacaoController _anotacaoController = Provider.of<AnotacaoController>(context);
    MediaQueryData deviceSize = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
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
              onDaySelected: (selectedDay) {
                AnotacaoModel? anotacao =
                    _anotacaoController.retornaAnotacaoDia(selectedDay);
                setState(() {});
              },
            ),
            Expanded(
              child: Anotacao(
                height: deviceSize.size.height * 0.5,
                width: deviceSize.size.width * 0.95,
                anotacoes: _anotacaoController.anotacoes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
