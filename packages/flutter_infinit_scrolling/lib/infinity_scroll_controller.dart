import 'package:flutter/material.dart';
import 'package:flutter_infinit_scrolling/infinit_exception.dart';

class InfinityScrollController extends ValueNotifier<List<Widget>> {
  InfinityScrollController(super.value) {
    scrollController.addListener(_scrollListener);
    if (value.isEmpty) return;
    add(value);
  }

  final scrollController = ScrollController();
  // Private variable for maintaining children
  List<Widget> children = [];

  //LISTENS FOR THE SCROLL POSITION
  void _scrollListener() {
    final pixelPosition = scrollController.position.pixels;
    final maxScrollExtent = scrollController.position.maxScrollExtent;

    if (pixelPosition == maxScrollExtent) {
      print(pixelPosition);
    }
  }

  /// Adds a list of new children to the notifier.
  /// Ensures all keys are present and unique.
  void add(List<Widget> children) {
    _mergeChildren(children);
    notifyListeners();
  }

  // Private method for merging new children, ensuring key constraints
  void _mergeChildren(List<Widget> newChildren) {
    _validateChildren(newChildren);
    children = _mergedList(newChildren);
  }

  // Private validation ensuring keys are present and unique
  void _validateChildren(List<Widget> newChildren) {
    for (final child in newChildren) {
      if (child.key == null) {
        throw KeyIsNullException('All children must have non-null keys.', null);
      }
    }
    final keySet = <Key>{};

    for (final child in newChildren) {
      if (!keySet.add(child.key!)) {
        // Use of '!' is justified by prior validation
        throw DuplicateKeyException(
            'All children must have unique keys.', null);
      }
    }
  }

  // Private method for creating a merged list, preserving uniqueness
  List<Widget> _mergedList(List<Widget> newChildren) {
    final uniqueItems = {...children};
    uniqueItems.addAll(newChildren);
    return uniqueItems.toList();
  }
}
