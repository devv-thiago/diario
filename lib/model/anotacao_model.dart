class AnotacaoModel {
  String conteudo, caminhoImagem;
  String dataAnotacao = DateTime.now().toString();

  AnotacaoModel({required this.conteudo, this.caminhoImagem = ""});
}
