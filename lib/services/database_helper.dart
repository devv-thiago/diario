import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  DatabaseHelper();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('anotacoes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Anotacoes ( 
            dataAnotacao TEXT PRIMARY KEY, 
            conteudo TEXT NOT NULL,
            caminhoImagem TEXT NOT NULL
          );
        ''');
      },
    );
  }

  Future<String> deletarAnotacao(String dataAnotacao) async {
    try {
      final db = await database;
      await db.delete(
        'Anotacoes',
        where: 'dataAnotacao = ?',
        whereArgs: [dataAnotacao],
      );
      return "Anotação deletada com sucesso";
    } catch (e) {
      debugPrint("Erro ao deletar anotação: $e");
      return "Erro ao deletar anotação";
    }
  }

  Future<String> inserirAnotacao(AnotacaoModel novaAnotacao) async {
    try {
      final db = await database;
      await db.insert(
        'Anotacoes',
        novaAnotacao.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return "Anotação cadastrada com sucesso";
    } catch (e) {
      debugPrint("Erro ao inserir anotação: $e");
      return "Erro ao inserir anotação";
    }
  }

  Future<String> atualizarAnotacao(
      String dataAnotacao, AnotacaoModel anotacao) async {
    try {
      final db = await database;
      await db.update(
        'Anotacoes',
        anotacao.toMap(),
        where: 'dataAnotacao = ?',
        whereArgs: [dataAnotacao],
      );
      return "Anotação atualizada com sucesso";
    } catch (e) {
      debugPrint("Erro ao atualizar anotação: $e");
      return "Erro ao atualizar anotação";
    }
  }

  Future<List<AnotacaoModel>> buscarAnotacoes() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('Anotacoes');
      return maps.isNotEmpty
          ? maps.map((map) => AnotacaoModel.fromMap(map)).toList()
          : [];
    } catch (e) {
      debugPrint("Erro ao buscar anotações: $e");
      return [];
    }
  }
}
