import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Encrypts chat text / attachment urls the way stored messages expect.
String encryptChatText(String str) {
  final chatSecret = dotenv.get('CHAT_SECRET');

  final keyHex = chatSecret.substring(0, 64);
  final ivHex = chatSecret.substring(0, 32);

  final key = encrypt.Key.fromBase16(keyHex);
  final iv = encrypt.IV.fromBase16(ivHex);

  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  return encrypter.encrypt(str, iv: iv).base16;
}
