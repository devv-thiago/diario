import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diario/model/anotacao.dart';
import 'package:diario/services/prefs_provider.dart';

class AnotacaoController extends ChangeNotifier implements SharedProvider {
  late final SharedPreferences _prefs;
  bool _isLoaded = false;

  AnotacaoController() {
    initRepo();
  }

  bool get isLoaded => _isLoaded;

  @override
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

  @override
  Future<bool> escritaValor(AnotacaoModel anotacao) async {
    if (!_isLoaded) return false;

    bool result = await _prefs.setStringList(anotacao.dataAnotacao.toString(), [
      anotacao.conteudo,
      anotacao.caminhoImagem,
    ]);
    return result;
  }

  @override
  Future<bool> excluirValor(DateTime dataAnotacao) async {
    if (!_isLoaded) return false;

    bool result = await _prefs.remove(dataAnotacao.toString());
    notifyListeners();
    return result;
  }

  @override
  List<String>? leituraValor(DateTime dataAnotacao) {
    if (!_isLoaded) return null;

    return _prefs.getStringList(dataAnotacao.toString());
  }

  @override
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
