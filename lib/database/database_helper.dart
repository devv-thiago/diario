import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late final Database database;

  DatabaseHelper();

  static Future initDatabase() async {
    try {
      database = await openDatabase(
          join(await getDatabasesPath(), 'database.db'),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Anotacoes ( 
            dataAnotacao TEXT PRIMARY KEY, 
            conteudo TEXT NOT NULL,
            caminhoImagem TEXT NOT NULL
          );
        ''');
      });
      debugPrint("Banco criado com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deletarAnotacao(String dataAnotacao) async {
    try {
      await database.rawDelete(
          "DELETE FROM Anotacoes WHERE dataAnotacao = ?", [dataAnotacao]);
      debugPrint("Anotação deletada");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> inserirAnotacao(AnotacaoModel novaAnotacao) async {
    try {
      await database.rawInsert('''
        INSERT INTO Anotacoes (dataAnotacao, conteudo, caminhoImagem) 
        VALUES (?, ?, ?)
      ''', [
        novaAnotacao.dataAnotacao.toString(),
        novaAnotacao.conteudo,
        novaAnotacao.caminhoImagem
      ]);
      debugPrint("Anotação cadastrada com sucesso");
      await database.rawQuery("SELECT * FROM Anotacoes");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> atualizarAnotacao(
      String dataAnotacao, AnotacaoModel anotacao) async {
    try {
      await database.rawUpdate('''
        UPDATE Anotacoes SET 
          dataAnotacao = ?, 
          conteudo = ?, 
          caminhoImagem = ? 
        WHERE dataAnotacao = ?
      ''', [
        anotacao.dataAnotacao.toString(),
        anotacao.conteudo,
        anotacao.caminhoImagem,
        dataAnotacao
      ]);
      debugPrint("Anotação atualizada com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> buscarAnotacao(String dataAnotacao) async {
    try {
      List<Map<String, dynamic>> result = await database.rawQuery(
          "SELECT * FROM Anotacoes WHERE dataAnotacao = ?", [dataAnotacao]);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
