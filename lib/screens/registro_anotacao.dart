import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:diario/controller/anotacao.dart';
import 'package:diario/model/anotacao.dart';

class RegistroAnotacaoPage extends StatefulWidget {
  final DateTime selectedDay;

  const RegistroAnotacaoPage({super.key, required this.selectedDay});

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
    super.initState();
    _selectedAlign = TextAlign.left;
    _conteudoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final anotacaoController = Provider.of<AnotacaoController>(context);
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 246, 246, 1),
      body: Consumer<AnotacaoController>(
        builder: (context, anotacaoController, child) {
          if (!anotacaoController.isLoaded) {
            // Exibe um indicador de carregamento enquanto os SharedPreferences são carregados
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedAlign = TextAlign.left;
                        });
                      },
                      icon: const Icon(
                        Icons.format_align_left,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedAlign = TextAlign.center;
                        });
                      },
                      icon: const Icon(
                        Icons.format_align_center,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedAlign = TextAlign.right;
                        });
                      },
                      icon: const Icon(
                        Icons.format_align_right,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isBold = !_isBold;
                        });
                      },
                      icon: Icon(
                        Icons.format_bold_rounded,
                        size: 35,
                        color: _isBold ? Colors.black : Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Placeholder for future image picking implementation
                      },
                      icon: const Icon(
                        Icons.photo_library_rounded,
                        size: 35,
                      ),
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
                          fontWeight:
                              _isBold ? FontWeight.bold : FontWeight.normal,
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
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 112, 137, 1)),
                    elevation: MaterialStateProperty.all(10),
                  ),
                  onPressed: () {
                    _salvarAnotacao(anotacaoController);
                  },
                  child: Text(
                    'Salvar Anotação',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _salvarAnotacao(AnotacaoController anotacaoController) async {
    try {
      resultado = await anotacaoController.atualizarValor(
        AnotacaoModel(
          dataAnotacao: widget.selectedDay,
          conteudo: _conteudoController.text,
          caminhoImagem:
              '', // Adicione lógica para lidar com imagem se necessário
        ),
      );
      debugPrint('Resultado do salvamento: $resultado');

      Navigator.of(context).pop(); // Fecha a tela de cadastro após salvar
    } catch (e) {
      debugPrint('Erro ao salvar anotação: $e');
      // Implemente o tratamento de erro conforme necessário
    }
  }
}
