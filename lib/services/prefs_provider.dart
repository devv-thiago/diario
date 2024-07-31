import 'package:diario/model/anotacao.dart';

abstract class SharedProvider {
  void initRepo() {}

  void leituraValor(List anotacoes, DateTime dataAnotacao) {}

  void escritaValor(DateTime dataAnotacao, AnotacaoModel novaAnotacao) {}

  void excluirValor() {}

  void atualizarValor() {}
}
