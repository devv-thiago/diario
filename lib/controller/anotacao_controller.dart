import 'package:diario/services/database_helper.dart';
import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/material.dart';

class AnotacaoController extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<AnotacaoModel> _anotacoes = [];

  List<AnotacaoModel> get anotacoes => _anotacoes;

  dynamic resultado;

  Future<String> adicionarAnotacao(AnotacaoModel novaAnotacao) async {
    resultado = await _databaseHelper.inserirAnotacao(novaAnotacao);
    _anotacoes.add(novaAnotacao);
    notifyListeners();
    return resultado;
  }

  Future<String> atualizarAnotacao(
      String dataAnotacao, AnotacaoModel anotacao) async {
    resultado = await _databaseHelper.atualizarAnotacao(dataAnotacao, anotacao);
    notifyListeners();
    return resultado;
  }

  Future<String> excluirAnotacao(String dataAnotacao) async {
    resultado = await _databaseHelper.deletarAnotacao(dataAnotacao);
    notifyListeners();
    return resultado;
  }

  Future<void> visualizarAnotacoes() async {
    try {
      _anotacoes = await _databaseHelper.buscarAnotacoes();
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao buscar anotações: $e');
      _anotacoes = [];
      notifyListeners();
    }
  }

  AnotacaoModel? retornaAnotacaoDia(DateTime day) {
    if (_anotacoes.isEmpty) {
      visualizarAnotacoes();
    }

    for (var anotacao in _anotacoes) {
      if (anotacao.dataAnotacao == day) {
        return anotacao;
      }
    }
    return null;
  }
}