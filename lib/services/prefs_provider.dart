import 'package:diario/model/anotacao.dart';

abstract class SharedProvider {
  void initRepo() {}

  void leituraValor(DateTime dataAnotacao) {}

  void escritaValor(AnotacaoModel novaAnotacao) {}

  void excluirValor(DateTime dataAnotacao) {}

  void atualizarValor(AnotacaoModel novaAnotacao) {}
}
