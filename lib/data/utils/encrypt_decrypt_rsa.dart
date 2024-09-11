import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptionUtils {
  late encrypt.Encrypter _encrypter;
  late RSAPublicKey _publicKey;

  static final EncryptionUtils _instance = EncryptionUtils._internal();

  factory EncryptionUtils() {
    return _instance;
  }

  EncryptionUtils._internal();

  Future<void> initialize() async{
    await _initializeRSAKeys();
  }

  Future<void> _initializeRSAKeys() async {
    final parser = encrypt.RSAKeyParser();
    final publicKeyString = await rootBundle.loadString('assets/sec/public_key.pem');
    _publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    _encrypter = encrypt.Encrypter(
      encrypt.RSA(
        publicKey: _publicKey,
        encoding: encrypt.RSAEncoding.PKCS1,
        digest: encrypt.RSADigest.SHA256,
      ),
    );
  }

  String encryptRSA(String plainText) {
    final encrypted = _encrypter.encrypt(plainText);
    return base64.encode(encrypted.bytes);
  }

  String decryptRSA(String encryptedText) {
    final decrypted = _encrypter.decrypt64(encryptedText);
    return decrypted;
  }
}
