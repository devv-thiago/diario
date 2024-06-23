class AnotacaoModel {
  String conteudo, caminhoImagem, dataAnotacao;

  AnotacaoModel(
      {required this.dataAnotacao,
      required this.conteudo,
      this.caminhoImagem = ""});

  factory AnotacaoModel.fromList(List<Map<String, dynamic>> lista) {
    return AnotacaoModel(
      dataAnotacao: lista[0]["dataAnotacao"],
      conteudo: lista[0]["conteudo"],
      caminhoImagem: lista[0]["caminhoImagem"],
    );
  }
}
