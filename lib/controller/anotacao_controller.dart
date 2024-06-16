import 'package:diario/database/database_helper.dart';
import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/foundation.dart';

class AnotacaoController {
  DatabaseHelper dbHelper = DatabaseHelper();
  void adicionarAnotacao(AnotacaoModel novaAnotacao) {
    try {
      dbHelper.inserirAnotacao(novaAnotacao);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void atualizarAnotacao(String dataAnotacao, AnotacaoModel anotacao) {
    try {
      dbHelper.atualizarAnotacao(dataAnotacao, anotacao);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void excluirAnotacao(String dataAnotacao) {
    try {
      dbHelper.deletarAnotacao(dataAnotacao);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void visualizarAnotacao(String dataAnotacao) {
    try {
      dbHelper.buscarAnotacao(dataAnotacao);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
