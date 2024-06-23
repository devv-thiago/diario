import 'package:diario/database/database_helper.dart';
import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/material.dart';

class AnotacaoController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  dynamic resultado;

  Future<String> adicionarAnotacao(AnotacaoModel novaAnotacao) async {
    resultado = await _databaseHelper.inserirAnotacao(novaAnotacao);
    return resultado;
  }

  Future<String> atualizarAnotacao(
      String dataAnotacao, AnotacaoModel anotacao) async {
    resultado = await _databaseHelper.atualizarAnotacao(dataAnotacao, anotacao);
    return resultado;
  }

  Future<String> excluirAnotacao(String dataAnotacao) async {
    resultado = await _databaseHelper.deletarAnotacao(dataAnotacao);
    return resultado;
  }

  Future<List<Map<String, dynamic>>> visualizarAnotacao(
      String dataAnotacao) async {
    try {
      List<Map<String, dynamic>> result =
          await _databaseHelper.buscarAnotacao(dataAnotacao);
      return result;
    } catch (e) {
      debugPrint('Erro ao buscar anotações: $e');
      return [];
    }
  }
}
