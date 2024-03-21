import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///Displays a given text with clickable links and tags
///
class ChatBubbleRichText extends StatelessWidget {
  const ChatBubbleRichText({
    super.key,
    required this.message,
    required this.tags,
  });
  final String? message;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: RichText(
        text: TextSpan(
          children: [
            ..._splitWithLinks(
              message ?? '',
              _allMatches(message),
              textTheme!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textTheme.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
              context,
            ),
          ],
        ),
      ),
    );
  }

  ///Find all links in a string and split them into a list of [InlineSpan]s
  ///with the links as [TextSpan]s
  ///
  List<InlineSpan> _splitWithLinks(
    String text,
    Iterable<RegExpMatch> links,
    TextStyle style,
    TextStyle linkStyle,
    BuildContext context,
  ) {
    final List<InlineSpan> result = [];
    int start = 0;

    for (final RegExpMatch link in links) {
      if (link.start != start) {
        result.add(TextSpan(
          text: text.substring(start, link.start),
          style: style,
        ));
      }
      final String linkText = text.substring(link.start, link.end);
      result.add(
        TextSpan(
          text: linkText,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              // //If the link is a hashtag, view the hashtag messages
              // if (linkText.startsWith('#')) {
              //   //context.push(ChatHashTagView.route, extra: linkText);

              //   //else if the link is a url, launch the url
              // } else {
              //   final uri = Uri.parse(linkText);
              //   final canLanuch = await EESUpException.guardFuture(
              //       action: () => canLaunchUrl(uri));

              //   canLanuch.fold((l) {
              //     showSnackBar(context: context, message: l.message);
              //   }, (can) async {
              //     if (can) {
              //       if (canLanuch.isRight()) {
              //         final result = await EESUpException.guardFuture(
              //             action: () => launchUrl(uri));
              //         result.fold((l) {
              //           showSnackBar(context: context, message: l.message);
              //         }, (r) {});
              //       }
              //     } else {
              //       showSnackBar(
              //         context: context,
              //         message: 'Unable to visit this url.',
              //       );
              //     }
               // });
             // }
            },
        ),
      );
      start = link.end;
    }
    if (start < text.length) {
      result.add(
        TextSpan(
          text: text.substring(start, text.length),
          style: style,
        ),
      );
    }

    return result;
  }

  Iterable<RegExpMatch> _allMatches(String? text) {
    if (text == null) {
      return [];
    } else {
      // Create a regular expression pattern for the tags
      final String tagsPattern = tags.join('|').replaceAll('#', '#\\b');

      // Combine URL and tag patterns
      final RegExp combinedRegExp = RegExp(
        r'(https?|ftp|mailto)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+|\b(?:[a-zA-Z0-9-]+\.){1,}[a-zA-Z]{2,}\b|' +
            tagsPattern,
      );

      final Iterable<RegExpMatch> matches = combinedRegExp.allMatches(text);
      return matches;
    }
  }
}
