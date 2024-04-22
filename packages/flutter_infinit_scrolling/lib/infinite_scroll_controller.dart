import 'package:flutter/material.dart';
import 'package:flutter_infinit_scrolling/infinite_value_notifier.dart';

class InfiniteScrollController {
  InfiniteScrollController({
    required List<Widget> initChildren,
    required this.onLoad,
  }) {
    _valueNotifier = InfiniteValueNotifier(initChildren);
    scrollController.addListener(_scrollListener);
  }
  final scrollController = ScrollController();
  late final InfiniteValueNotifier _valueNotifier;
  final void Function(InfiniteScrollController controller) onLoad;

  //LISTENS FOR THE SCROLL POSITION
  void _scrollListener() {
    final pixelPosition = scrollController.position.pixels;
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    if (pixelPosition == maxScrollExtent) {
      onLoad.call(this);
    }
  }

  List<Widget> get children => _valueNotifier.children;

  void add(List<Widget> children) => _valueNotifier.add(children);
}
