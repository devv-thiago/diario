import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:diario/screens/registro_anotacao.dart';
import 'package:provider/provider.dart';
import 'package:diario/controller/anotacao.dart';

class Anotacao extends StatelessWidget {
  final double height;
  final double width;
  final DateTime selectedDay;

  const Anotacao({
    required this.height,
    required this.width,
    required this.selectedDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final anotacaoController = Provider.of<AnotacaoController>(context);

    return FutureBuilder<List<String>?>(
      future: _loadAnotacao(anotacaoController),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Erro ao carregar anotações: ${snapshot.error}"));
        } else {
          final anotacao = snapshot.data;

          final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
          final String formattedDate = dateFormat.format(selectedDay);
          final String dayOfWeek =
              DateFormat('EEEE', 'pt_BR').format(selectedDay);

          final String capitalizedDayOfWeek =
              dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);

          if (anotacao != null && anotacao.isNotEmpty) {
            return _buildAnotacaoCard(context, formattedDate,
                capitalizedDayOfWeek, anotacao[0], anotacaoController);
          } else {
            return _buildEmptyAnotacao(
              context,
              formattedDate,
              capitalizedDayOfWeek,
            );
          }
        }
      },
    );
  }

  Future<List<String>?> _loadAnotacao(
      AnotacaoController anotacaoController) async {
    return anotacaoController.leituraValor(selectedDay);
  }

  Widget _buildAnotacaoCard(
      BuildContext context,
      String formattedDate,
      String dayOfWeek,
      String conteudo,
      AnotacaoController anotacaoController) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 25, right: 15, bottom: 10, top: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              "Meus dias",
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.5,
            width: width,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistroAnotacaoPage(
                      conteudo,
                      selectedDay: selectedDay,
                      dayOfWeek: dayOfWeek,
                      formattedDate: formattedDate,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 10,
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dayOfWeek,
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                size: 35,
                                Icons.delete,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              onPressed: () {
                                anotacaoController.excluirValor(selectedDay);
                              },
                            ),
                          ],
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              conteudo,
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
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

  Widget _buildEmptyAnotacao(
    BuildContext context,
    String formattedDate,
    String dayOfWeek,
  ) {
    return SizedBox(
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
              color: Colors.black.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
