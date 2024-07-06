import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:diario/model/anotacao_model.dart';
import 'package:diario/screens/registro_anotacao_page.dart';

// ignore: must_be_immutable
class Anotacao extends StatelessWidget {
  final double height;
  final double width;
  List<AnotacaoModel> anotacoes;
  DateTime selectedDay;

  Anotacao({
    required this.height,
    required this.width,
    required this.selectedDay,
    required this.anotacoes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Filtra a anotação para o dia selecionado
    final anotacaoFiltrada = anotacoes.firstWhere(
      (anotacao) =>
          anotacao.dataAnotacao.year == selectedDay.year &&
          anotacao.dataAnotacao.month == selectedDay.month &&
          anotacao.dataAnotacao.day == selectedDay.day,
      orElse: () => AnotacaoModel(conteudo: '', dataAnotacao: selectedDay),
    );

    // Verifica se há uma anotação para o dia selecionado
    bool hasAnotacao = anotacaoFiltrada.conteudo.isNotEmpty;

    // Formata a data e o dia da semana
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String formattedDate =
        dateFormat.format(anotacaoFiltrada.dataAnotacao);
    final String dayOfWeek =
        DateFormat('EEEE', 'pt_BR').format(anotacaoFiltrada.dataAnotacao);

    if (!hasAnotacao) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistroAnotacaoPage(selectedDay: selectedDay,),
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
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Meus dias",
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.5,
              width: width,
              child: Card(
                elevation: 10,
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Text(
                        dayOfWeek,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                          const SizedBox(height: 8.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              anotacaoFiltrada.conteudo,
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}