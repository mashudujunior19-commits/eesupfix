import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/message_bubble.dart';

class ReviewMessagesDialog extends StatefulWidget {
  const ReviewMessagesDialog({super.key, required this.pool});
  final EESUpool pool;

  @override
  State<ReviewMessagesDialog> createState() => _ReviewMessagesDialogState();
}

class _ReviewMessagesDialogState extends State<ReviewMessagesDialog> {
  // Future<void> deleteMessage(
  //   WidgetRef ref,
  //   BuildContext context,
  //   int messageId,
  // ) async {
  //   final result =
  //       await ref.read(eesupoolRepoProvider).softDeleteChatMessage(messageId);
  //   result.fold((l) {
  //     showSnackBar(context: context, message: l.message);
  //   }, (r) => null);
  // }

  // Future<void> approveMessage(
  //   WidgetRef ref,
  //   BuildContext context,
  //   int messageId,
  // ) async {
  //   final result =
  //       await ref.read(eesupoolRepoProvider).approveMessage(messageId);
  //   result.fold((l) {
  //     showSnackBar(context: context, message: l.message);
  //   }, (r) => null);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Review messages'),
      ),
      body: Container(
        decoration: context.bgImage,
        height: context.height,
        width: context.width,
        child: FutureBuilder<Either<EESUpException, List<ChatMessage>>>(
          future: context.read<EESUpoolRepository>().getUnAprovedChatMessages(
                widget.pool.eesupoolId!,
                1000,
              ),
          builder: (context, snap) {
            if (snap.hasData) {
              final data = snap.data;
              return data?.fold((l) {
                    return FullScreenError(exception: l);
                  }, (r) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      itemCount: r.length,
                      itemBuilder: (context, index) {
                        final message = r[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MessageBubble(message: r[index], pool: widget.pool),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final repo =
                                        context.read<EESUpoolRepository>();

                                    context.loaderOverlay.show();
                                    final results = await repo.approveMessage(
                                      message.id,
                                    );
                                    context.loaderOverlay.hide();
                                    results.fold((l) {}, (r) {
                                      setState(() {});
                                    });
                                  },
                                  child: const Text('✅ Approve'),
                                ),
                                20.sW,
                                TextButton(
                                  onPressed: () async {
                                    final repo =
                                        context.read<EESUpoolRepository>();

                                    context.loaderOverlay.show();
                                    final results = await repo
                                        .softDeleteChatMessage(message.id);
                                    context.loaderOverlay.hide();
                                    results.fold((l) {}, (r) {
                                      setState(() {});
                                    });
                                  },
                                  child: const Text(
                                    '❌ Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  }) ??
                  FullScreenError(
                    isError: false,
                    exception: EESUpException(message: "Nothing to show here."),
                  );
            } else if (snap.connectionState == ConnectionState.waiting) {
              return const FullScreenLoadingShimmer();
            } else {
              return FullScreenError(
                isError: false,
                exception: EESUpException(message: "Nothing to show here."),
              );
            }
          },
        ),
      ),
    );
  }
}
