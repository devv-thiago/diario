import 'package:diario/controller/anotacao_controller.dart';
import 'package:diario/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:diario/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();
  await initializeDateFormatting();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AnotacaoController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      locale: Locale('pt', 'BR'), // Define o local para Português (Brasil)
      supportedLocales: [
        Locale('en', 'US'), // Inglês
        Locale('pt', 'BR'), // Português (Brasil)
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Homepage(),
    );
  }
}
