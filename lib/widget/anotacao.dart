import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Anotacao extends StatelessWidget {
  final double height;
  final double width;

  const Anotacao({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              child: ListTile(
                subtitle: Text(
                  'Sem descrição',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
