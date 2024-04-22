import 'package:flutter/material.dart';
import 'package:flutter_infinit_scrolling/infinite_scroll_controller.dart';


class InfinitListView extends ListView {
  InfinitListView({
    super.key,
    required this.infiniteController,
  });
  
  final InfiniteScrollController infiniteController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: infiniteController.scrollController,
      children: [...infiniteController.children],
    );
  }
}
