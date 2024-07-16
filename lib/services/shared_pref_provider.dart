import 'package:diario/model/anotacao_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider {
  late SharedPreferences prefs;

  SharedPrefProvider() {
    _initRepo();
  }

  void _initRepo() async {
    try {
      prefs = await SharedPreferences.getInstance().onError((e, S) {
        throw Exception("Erro shared prefs: $e");
      });
    } catch (e) {
      throw Exception("Ocorreu um erro no método");
    }
  }

  String leituraValor(List anotacoes, DateTime dataAnotacao) {
    if (prefs.containsKey(dataAnotacao.toString())) {
      final anotacaoModel = prefs.getStringList(dataAnotacao.toString());
      anotacoes.add(anotacaoModel); // adiciona valor na lista do controller
      return "Anotação encontrada";
    } else {
      return "Anotação não encontrada";
    }
  }

  String escritaValor(DateTime dataAnotacao, AnotacaoModel novaAnotacao) {
    if (prefs.containsKey(dataAnotacao.toString())) {
      String resultadoAtt = atualizarValor();
      return "Resultado atualização: $resultadoAtt";
    } else {
      final anotacaoModel = prefs
          .setString(
        dataAnotacao.toString(),
        "{${novaAnotacao.conteudo},${novaAnotacao.caminhoImagem}}",
      )
          .then((result) {
        return "Resultado $result";
      }).onError((e, s) {
        return "Erro $e";
      });
    }
    // se existir chama atualizaValor
    // senão apenas adiciona novo valor
  }

  String excluirValor() {
    // verifica se valor existe
    // se existir exclui o valor
    return "";
  }

  String atualizarValor() {
    // verifica se valor existe
    // se existir exclui o valor
    // após exclusão grava novo valor
    return "";
  }
}
