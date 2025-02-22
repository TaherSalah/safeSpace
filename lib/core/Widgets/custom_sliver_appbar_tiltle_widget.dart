import 'package:flutter/material.dart';

class CustomSliverAppBarTitleWidget extends StatefulWidget {
  final Widget child;
  const CustomSliverAppBarTitleWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  State<CustomSliverAppBarTitleWidget> createState() {
    return _CustomSliverAppBarTitleWidgetState();
  }
}

class _CustomSliverAppBarTitleWidgetState
    extends State<CustomSliverAppBarTitleWidget> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible ?? false,

      child: widget.child,
      // Container(
      //   color: const Color(0xff315FAA),
      //     child: widget.child,
      // ),
    );
  }
}
