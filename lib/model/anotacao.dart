class AnotacaoModel {
  DateTime dataAnotacao;
  String conteudo;
  String caminhoImagem;

  AnotacaoModel({
    required this.dataAnotacao,
    required this.conteudo,
    this.caminhoImagem = "",
  });
}
