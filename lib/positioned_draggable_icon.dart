import 'package:flutter/material.dart';

class PositionedDraggableIcon extends StatefulWidget {
  final double top;
  final double left;

  PositionedDraggableIcon({Key key, this.top, this.left}) : super(key: key);

  @override
  _PositionedDraggableIconState createState() => _PositionedDraggableIconState();
}

class _PositionedDraggableIconState extends State<PositionedDraggableIcon> {
  GlobalKey _key = GlobalKey();
  double top, left;
  double xOff, yOff;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    top = widget.top;
    left = widget.left;
    super.initState();
  }

  void _getRenderOffsets() {
    final RenderBox renderBoxWidget = _key.currentContext.findRenderObject();
    final offset = renderBoxWidget.localToGlobal(Offset.zero);

    yOff = offset.dy;
    xOff = offset.dx;;
  }

  void _afterLayout(_) {
    _getRenderOffsets();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: _key,
      top: top,
      left: left,
      child: Draggable(
        child: Icon(Icons.input),
        feedback: Icon(Icons.input),
        childWhenDragging: Container(),
        onDragEnd: (drag) {
          setState(() {
            top = drag.offset.dy - yOff;
            left = drag.offset.dx - xOff;
          });
        },
      ),
    );
  }
}