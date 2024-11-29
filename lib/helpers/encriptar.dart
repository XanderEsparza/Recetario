import 'dart:convert';
import 'package:crypto/crypto.dart';

String encriptarPassword(String password) {
  final bytes = utf8.encode(password);

  final hash = sha256.convert(bytes);

  return hash.toString();
}
