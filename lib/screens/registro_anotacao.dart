import 'package:diario/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:diario/controller/anotacao.dart';
import 'package:diario/model/anotacao.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

class RegistroAnotacaoPage extends StatefulWidget {
  final DateTime selectedDay;
  final String? conteudo;
  final String dayOfWeek;
  final String formattedDate;

  RegistroAnotacaoPage(
    this.conteudo, {
    super.key,
    required this.selectedDay,
    required this.dayOfWeek,
    required this.formattedDate,
  });

  @override
  State<RegistroAnotacaoPage> createState() => _RegistroAnotacaoPageState();
}

class _RegistroAnotacaoPageState extends State<RegistroAnotacaoPage> {
  late TextAlign _selectedAlign;
  bool _isBold = false;
  late TextEditingController _conteudoController;
  dynamic resultado;
  List<File> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    _selectedAlign = TextAlign.left;
    _conteudoController = TextEditingController(text: widget.conteudo ?? "");
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 246, 246, 1),
      body: Consumer<AnotacaoController>(
        builder: (context, anotacaoController, child) {
          if (!anotacaoController.isLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    width: deviceInfo.size.width,
                    height: deviceInfo.size.height * 0.18,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dayOfWeek,
                          style: GoogleFonts.poppins(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.formattedDate,
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedAlign = TextAlign.left;
                          });
                        },
                        icon: const Icon(
                          Icons.format_align_left,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedAlign = TextAlign.center;
                          });
                        },
                        icon: const Icon(
                          Icons.format_align_center,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedAlign = TextAlign.right;
                          });
                        },
                        icon: const Icon(
                          Icons.format_align_right,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isBold = !_isBold;
                          });
                        },
                        icon: Icon(
                          Icons.format_bold_rounded,
                          size: 40,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _pickImage();
                        },
                        icon: const Icon(
                          Icons.photo_library_rounded,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: deviceInfo.size.height * 0.4,
                    width: deviceInfo.size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(8, 10),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: CarouselSlider(
                          items: [
                            SizedBox(
                              child: TextFormField(
                                controller: _conteudoController,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: _isBold
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                textAlign: _selectedAlign,
                                maxLines: null,
                                expands: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (_imageFiles.isNotEmpty)
                              ..._imageFiles.asMap().entries.map(
                                (entry) {
                                  int index = entry.key;
                                  File file = entry.value;
                                  return Stack(
                                    children: [
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            _removeImage(index);
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: Image.file(
                                          file,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                          ],
                          options: CarouselOptions(
                            height: deviceInfo.size.height * 0.4,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: deviceInfo.size.width,
                    height: deviceInfo.size.height * 0.07,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(255, 112, 137, 1)),
                        elevation: WidgetStateProperty.all(10),
                      ),
                      onPressed: () {
                        _salvarAnotacao(anotacaoController);
                      },
                      child: Text(
                        'Salvar Anotação',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _salvarAnotacao(AnotacaoController anotacaoController) async {
    try {
      resultado = await anotacaoController.atualizarValor(
        AnotacaoModel(
          dataAnotacao: widget.selectedDay,
          conteudo: _conteudoController.text,
          caminhoImagem: _imageFiles.isNotEmpty ? _imageFiles[0].path : '',
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Homepage(),
        ),
      );
    } catch (e) {
      debugPrint('Erro ao salvar anotação: $e');
    }
  }
}
