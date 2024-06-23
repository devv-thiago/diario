import 'package:flutter/material.dart';

class Anotacao extends StatelessWidget {
  final double height;
  final double width;
  final List<Map<String, dynamic>> anotacoes;

  const Anotacao({
    required this.height,
    required this.width,
    required this.anotacoes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          const Text(
            "Meus Dias",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: anotacoes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(anotacoes[index]['titulo'] ?? 'Sem título'),
                    subtitle:
                        Text(anotacoes[index]['descricao'] ?? 'Sem descrição'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
