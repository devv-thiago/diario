import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diario/model/anotacao_model.dart';
import 'package:diario/screens/registro_anotacao_page.dart'; // Importe a tela de cadastro de anotação aqui

class Anotacao extends StatelessWidget {
  final double height;
  final double width;
  final List<AnotacaoModel> anotacoes;

  const Anotacao({
    required this.height,
    required this.width,
    required this.anotacoes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (anotacoes.isEmpty) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistroAnotacaoPage(),
            ),
          );
        },
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Clique aqui para adicionar uma anotação",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Meus Dias",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Card(
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListView.builder(
                  itemCount: anotacoes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        anotacoes[index].conteudo,
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
