import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diario/model/anotacao.dart';

class AnotacaoController extends ChangeNotifier {
  late final SharedPreferences _prefs;
  bool _isLoaded = false;

  AnotacaoController() {
    initRepo();
  }

  bool get isLoaded => _isLoaded;

  Future<String> atualizarValor(AnotacaoModel anotacao) async {
    if (!_isLoaded) return "SharedPreferences não carregado ainda.";

    List<String>? result =
        _prefs.getStringList(anotacao.dataAnotacao.toString());
    if (result != null) {
      bool result2 = await excluirValor(anotacao.dataAnotacao);
      if (result2) {
        result2 = await escritaValor(anotacao);
        if (result2) {
          return "Novo valor gravado.";
        } else {
          return "Erro ao gravar novo valor.";
        }
      } else {
        return "Erro ao excluir valor";
      }
    } else {
      await escritaValor(anotacao);
    }
    return "Operação realizada.";
  }

  Future<bool> escritaValor(AnotacaoModel anotacao) async {
    if (!_isLoaded) return false;

    bool result = await _prefs.setStringList(
        anotacao.dataAnotacao.toString(), anotacao.conteudo);
    return result;
  }

  Future<bool> excluirValor(DateTime dataAnotacao) async {
    if (!_isLoaded) return false;

    bool result = await _prefs.remove(dataAnotacao.toString());
    notifyListeners();
    return result;
  }

  List<String>? leituraValor(DateTime dataAnotacao) {
    if (!_isLoaded) return null;

    return _prefs.getStringList(dataAnotacao.toString());
  }

  List<DateTime> listarDatasComAnotacoes() {
    if (!_isLoaded) return [];

    final List<DateTime> datasComAnotacoes = [];

    for (String key in _prefs.getKeys()) {
      if (_prefs.getStringList(key) != null) {
        try {
          final DateTime date = DateTime.parse(key);
          datasComAnotacoes.add(date);
        } catch (e) {
          debugPrint("$e");
        }
      }
    }

    return datasComAnotacoes;
  }

  void initRepo() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _isLoaded = true;
      notifyListeners(); // Notifica os listeners quando o carregamento estiver concluído
    } catch (e) {
      throw Exception("Ocorreu um erro no método initRepo: $e");
    }
  }
}
