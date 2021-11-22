import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NoGlowScrollBehavior extends MaterialScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class SimpleSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  const SimpleSliverPersistentHeader({
    required this.child,
    required double maxExtent,
    double minExtent = 0,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  final Widget child;

  final double _maxExtent;
  final double _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      child;
}
