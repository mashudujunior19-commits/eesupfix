import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_hash_tag_view.dart';

class MessageText extends StatelessWidget {
  const MessageText({
    super.key,
    this.padding,
    required this.message,
    required this.pool,
  });
  final EdgeInsets? padding;
  final ChatMessage message;
  final EESUpool pool;

  String _decrypt(String str) {
    // Generate a key
    final key = encrypt.Key.fromBase16(dotenv.get('CHAT_SECRET'));
    final iv = encrypt.IV.fromBase16(dotenv.get('CHAT_SECRET'));
    final decrypter = encrypt.Encrypter(encrypt.AES(key));
    // Encrypt the plain text
    final res = decrypter.decrypt(encrypt.Encrypted.fromBase16(str), iv: iv);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 5,
          ),
      child: HighlightedText(
        _decrypt(message.content!),
        patterns: [...pool.chatTags ?? []],
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        highLightStyle: context.textTheme.bodySmall?.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          fontSize: 16,
        ),
        onTap: (p) {
          FocusScope.of(context).unfocus();
          context.showDialog(
            margin: EdgeInsets.only(top: context.height * .1),
            child: ChatHashTagView(pool: pool, tag: p),
          );
        },
      ),
    );
  }
}
