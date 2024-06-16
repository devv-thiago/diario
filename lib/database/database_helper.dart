import 'package:diario/model/anotacao_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database database;

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Future<void> initDatabase({String path = ""}) async {
    try {
      _instance.database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute('''
          create table Anotacoes ( 
                    dataAnotacao TEXT PRIMARY KEY, 
                    titulo TEXT NOT NULL,
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

  Future deletarAnotacao(String dataAnotacao) async {
    try {
      await database.rawDelete(
          "DELETE FROM Anotacoes WHERE dataAnotacao = $dataAnotacao");
      debugPrint("Anotação deletada");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future inserirAnotacao(AnotacaoModel novaAnotacao) async {
    try {
      await database.rawInsert('''
            INSERT INTO Anotacoes(dataAnotacao, 
                                  titulo, 
                                  conteudo, 
                                  caminhoImagem) 
            VALUES (${novaAnotacao.dataAnotacao}, 
                    ${novaAnotacao.titulo}, 
                    ${novaAnotacao.conteudo}, 
                    ${novaAnotacao.caminhoImagem});
          ''');
      debugPrint("Anotação cadastrada com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future atualizarAnotacao(String dataAnotacao, AnotacaoModel anotacao) async {
    try {
      await database.rawInsert('''
                                UPDATE Anotacoes ;
                                SET dataAnotacao = ${anotacao.dataAnotacao},
                                    titulo = ${anotacao.titulo},
                                    conteudo = ${anotacao.conteudo},
                                    caminhoImagem = ${anotacao.caminhoImagem};
                              ''');
      debugPrint("Anotação atualizada com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future buscarAnotacao(String dataAnotacao) async {
    try {
      await database.rawInsert(
          "SELECT * FROM Anotacoes WHERE dataAnotacao = $dataAnotacao;");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
