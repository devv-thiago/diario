class AnotacaoModel {
  String conteudo;
  String caminhoImagem;
  String dataAnotacao; // Mantendo como String

  AnotacaoModel({
    required this.dataAnotacao,
    required this.conteudo,
    this.caminhoImagem = "",
  });

  factory AnotacaoModel.fromMap(Map<String, dynamic> map) {
    return AnotacaoModel(
      dataAnotacao: map["dataAnotacao"],
      conteudo: map["conteudo"],
      caminhoImagem: map["caminhoImagem"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "dataAnotacao": dataAnotacao,
      "conteudo": conteudo,
      "caminhoImagem": caminhoImagem,
    };
  }
}
