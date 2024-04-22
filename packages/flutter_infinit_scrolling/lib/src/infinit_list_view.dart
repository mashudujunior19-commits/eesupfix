import 'package:flutter/material.dart';
import 'package:flutter_infinit_scrolling/infinity_scroll_controller.dart';

class InfinitListView extends ListView {
  InfinitListView({
    super.key,
    required this.loadMoreNotifier,
    required this.infinitController,
  });

  final void Function() loadMoreNotifier;
  final InfinityScrollController infinitController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: infinitController.scrollController,
      children: [...infinitController.children],
    );
  }
}
