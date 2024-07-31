import 'package:diario/model/anotacao.dart';
import 'package:diario/services/prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnotacaoController extends ChangeNotifier implements SharedProvider {
  late final SharedPreferences _prefs;

  void retornaAnotacaoDia() {}

  AnotacaoController() {
    initRepo();
  }

  @override
  void atualizarValor() {
    // TODO: implement atualizarValor
  }

  @override
  void escritaValor(DateTime dataAnotacao, AnotacaoModel novaAnotacao) {
    _prefs.setStringList("", <String>[]);
  }

  @override
  void excluirValor() {
    _prefs.remove("");
  }

  @override
  void leituraValor(List anotacoes, DateTime dataAnotacao) {
    _prefs.getStringList("");
  }

  @override
  void initRepo() async {
    try {
      _prefs = await SharedPreferences.getInstance().onError((e, S) {
        throw Exception("Erro shared prefs: $e");
      });
    } catch (e) {
      throw Exception("Ocorreu um erro no método");
    }
  }
}
