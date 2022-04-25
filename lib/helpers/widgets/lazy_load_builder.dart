import 'package:flutter/widgets.dart';
import 'package:helpers/helpers.dart';

enum LazyLoadStatus { error, loading, completed, stable }

typedef LazyLoadWidgetBuilder = Widget Function(
  BuildContext context,
  ValueNotifier<LazyLoadStatus> status,
);

class LazyLoadBuilder extends StatefulWidget {
  const LazyLoadBuilder({
    Key? key,
    this.controller,
    this.onLoad,
    this.startLoadBeforeOffset = -80,
    required this.builder,
  }) : super(key: key);

  final Future<LazyLoadStatus?> Function()? onLoad;
  final LazyLoadWidgetBuilder builder;
  final ScrollController? controller;
  final double startLoadBeforeOffset;

  @override
  State<LazyLoadBuilder> createState() => _LazyLoadBuilderState();
}

class _LazyLoadBuilderState extends State<LazyLoadBuilder> {
  ScrollController? _scrollController;
  final ValueNotifier<LazyLoadStatus> _status =
      ValueNotifier(LazyLoadStatus.stable);

  @override
  void dispose() {
    _status.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Misc.onLayoutRendered(() {
      _scrollController =
          widget.controller ?? PrimaryScrollController.of(context);
      _scrollController?.addListener(_scrollListener);
    });
    super.initState();
  }

  bool get _canLoadMore => _status.value == LazyLoadStatus.stable;

  void _scrollListener() {
    final ScrollPosition position = _scrollController!.position;
    if (position.pixels >=
            (position.maxScrollExtent + widget.startLoadBeforeOffset) &&
        _canLoadMore) {
      _load();
    }
  }

  Future<void> _load() async {
    _status.value = LazyLoadStatus.loading;
    _status.value = (await widget.onLoad?.call()) ?? LazyLoadStatus.stable;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _status);
  }
}
