import 'package:flutter/material.dart';

class RegisterWargaVariables {
  final nikC = TextEditingController();
  final namaC = TextEditingController();
  final telpC = TextEditingController(text: "+62 ");
  final tempatLahirC = TextEditingController();
  final emailC = TextEditingController();
  final usernameC = TextEditingController();
  dynamic foto;

  DateTime? tglLahir;

  String? namaKepala;
  String? jk;
  String? agama;
  String? goldar;
  String? peran;
  String? pendidikan;
  String? pekerjaan;
  String? statusKependudukan;
  


  /// Dispose all controllers to avoid memory leaks.
  void dispose() {
    nikC.dispose();
    namaC.dispose();
    telpC.dispose();
    tempatLahirC.dispose();
    emailC.dispose();
  }
}
