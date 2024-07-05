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

  Future<String> deletarAnotacao(String dataAnotacao) async {
    try {
      await database.rawDelete(
          "DELETE FROM Anotacoes WHERE dataAnotacao = ?", [dataAnotacao]);
      return "Anotação deletada";
    } catch (e) {
      return "Anotação não deletada, erro: ${e.toString()}";
    }
  }

  Future<String> inserirAnotacao(AnotacaoModel novaAnotacao) async {
    try {
      await database.rawInsert('''
        INSERT INTO Anotacoes (dataAnotacao, conteudo, caminhoImagem) 
        VALUES (?, ?, ?)
      ''', [
        novaAnotacao.dataAnotacao.toString(),
        novaAnotacao.conteudo,
        novaAnotacao.caminhoImagem
      ]);
      return "Anotação cadastrada com sucesso";
    } catch (e) {
      return "Não foi possível inserir a anotacao, erro: ${e.toString()}";
    }
  }

  Future<String> atualizarAnotacao(
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
      return "Anotação atualizada com sucesso";
    } catch (e) {
      return "Não foi possível atualizar a anotação, erro:${e.toString()}";
    }
  }

  Future<List<AnotacaoModel>> buscarAnotacoes() async {
    try {
      final List<Map<String, dynamic>> maps =
          await database.rawQuery("SELECT * FROM Anotacoes");
      return List.generate(maps.length, (i) {
        return AnotacaoModel.fromMap(maps[i]);
      });
    } catch (e) {
      return [];
    }
  }
}
