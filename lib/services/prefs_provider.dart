import 'package:diario/model/anotacao.dart';

abstract class SharedProvider {
  void initRepo() {}

  void leituraValor(DateTime dataAnotacao) {}

  void escritaValor(AnotacaoModel novaAnotacao) {}

  void excluirValor(AnotacaoModel novaAnotacao) {}

  void atualizarValor(AnotacaoModel novaAnotacao) {}
}
