import 'dart:io';
import 'package:flutter/material.dart';



class KeluargaController extends ChangeNotifier {
  // Data kepala keluarga
  final namaKKC = TextEditingController();
  final noKKC = TextEditingController();
  final alamatC = TextEditingController();
  final emailC = TextEditingController();

  File? fotoKK;

  
}