import 'package:flutter/widgets.dart';

enum LazyLoadStatus { error, loading, completed, stable }

typedef LazyLoadWidgetBuilder = Widget Function(
  BuildContext context,
  ValueNotifier<LazyLoadStatus> status,
);

class LazyLoadBuilder extends StatefulWidget {
  const LazyLoadBuilder({
    Key? key,
    this.onLoad,
    required this.builder,
    required this.controller,
    this.startLoadBeforeOffset = -80,
    this.status,
  }) : super(key: key);

  final Future<LazyLoadStatus?> Function()? onLoad;
  final LazyLoadWidgetBuilder builder;
  final ScrollController controller;
  final double startLoadBeforeOffset;
  final ValueNotifier<LazyLoadStatus>? status;

  @override
  State<LazyLoadBuilder> createState() => _LazyLoadBuilderState();
}

class _LazyLoadBuilderState extends State<LazyLoadBuilder> {
  late ValueNotifier<LazyLoadStatus> _status;

  @override
  void dispose() {
    if (widget.status == null) _status.dispose();
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    _status = widget.status ?? ValueNotifier(LazyLoadStatus.stable);
    widget.controller.addListener(_scrollListener);
    super.initState();
  }

  bool get _canLoadMore => _status.value == LazyLoadStatus.stable;

  void _scrollListener() {
    if (!_canLoadMore) return;
    final ScrollPosition position = widget.controller.position;
    if (position.pixels >=
        (position.maxScrollExtent + widget.startLoadBeforeOffset)) {
      _load();
    }
  }

  Future<void> _load() async {
    _status.value = LazyLoadStatus.loading;
    _status.value = await widget.onLoad?.call() ??
        (_status.value != LazyLoadStatus.completed
            ? LazyLoadStatus.stable
            : LazyLoadStatus.completed);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _status);
  }
}
