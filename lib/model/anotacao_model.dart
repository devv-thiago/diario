import 'package:intl/intl.dart';

class AnotacaoModel {
  String conteudo;
  String caminhoImagem;
  DateTime dataAnotacao; // Alterado para DateTime

  AnotacaoModel({
    required this.dataAnotacao,
    required this.conteudo,
    this.caminhoImagem = "",
  });

  factory AnotacaoModel.fromMap(Map<String, dynamic> map) {
    return AnotacaoModel(
      dataAnotacao: DateTime.parse(
          map["dataAnotacao"]), // Convertendo de String para DateTime
      conteudo: map["conteudo"],
      caminhoImagem: map["caminhoImagem"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "dataAnotacao": DateFormat('yyyy-MM-dd').format(
          dataAnotacao), // Convertendo de DateTime para String no formato desejado
      "conteudo": conteudo,
      "caminhoImagem": caminhoImagem,
    };
  }
}
