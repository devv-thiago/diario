import 'package:diario/controller/anotacao_controller.dart';
import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistroAnotacaoPage extends StatefulWidget {
  const RegistroAnotacaoPage({Key? key}) : super(key: key);

  @override
  State<RegistroAnotacaoPage> createState() => _RegistroAnotacaoPageState();
}

class _RegistroAnotacaoPageState extends State<RegistroAnotacaoPage> {
  late TextAlign _selectedAlign;
  bool _isBold = false;
  late TextEditingController _conteudoController;
  dynamic resultado;

  @override
  void initState() {
    _selectedAlign = TextAlign.left;
    _conteudoController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final anotacaoController =
        Provider.of<AnotacaoController>(context, listen: false);
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 246, 246, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedAlign = TextAlign.left;
                    });
                  },
                  icon: const Icon(Icons.format_align_left),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedAlign = TextAlign.center;
                    });
                  },
                  icon: const Icon(Icons.format_align_justify),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedAlign = TextAlign.right;
                    });
                  },
                  icon: const Icon(Icons.format_align_right),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isBold = !_isBold;
                    });
                  },
                  icon: const Icon(Icons.format_bold_rounded),
                ),
              ],
            ),
            Container(
              height: deviceInfo.size.height * 0.4,
              width: deviceInfo.size.width,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(8, 10),
                    blurRadius: 10,
                  )
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _conteudoController,
                    style: TextStyle(
                      fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: _selectedAlign,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _salvarAnotacao(anotacaoController),
              child: const Text('Salvar Anotação'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarAnotacao(AnotacaoController anotacaoController) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    resultado = await anotacaoController.adicionarAnotacao(
      AnotacaoModel(
        dataAnotacao: DateTime.parse(formattedDate),
        conteudo: _conteudoController.text,
      ),
    );

    Navigator.of(context).pop(); // Fecha a tela de cadastro após salvar
  }
}
