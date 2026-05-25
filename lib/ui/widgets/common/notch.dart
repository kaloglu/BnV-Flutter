import 'package:BedavaNeVar/BnvApp.dart';
import 'package:flutter/material.dart';

class Notch extends StatelessWidget {
  final Widget child;
  final Color color;
  final NotchPosition position;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<BoxShadow> boxShadows;
  final double borderRadius;

  Notch({
    Key key,
    @required this.child,
    this.color,
    this.position = const NotchPosition.topCenter(),
    this.boxShadows,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    this.margin,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: position,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: buildBorderRadius(borderRadius),
          color: color,
          boxShadow: boxShadows,
        ),
        padding: padding,
        margin: margin,
        child: child,
      ),
    );
  }

  get _showBottomLeft =>
      position == Alignment.topRight ||
      position == Alignment.topCenter ||
      position == Alignment.centerRight ||
      position == Alignment.center;

  get _showBottomRight =>
      position == Alignment.topLeft ||
      position == Alignment.topCenter ||
      position == Alignment.centerLeft ||
      position == Alignment.center;

  get _showTopLeft =>
      position == Alignment.bottomRight ||
      position == Alignment.bottomCenter ||
      position == Alignment.centerRight ||
      position == Alignment.center;

  get _showTopRight =>
      position == Alignment.bottomLeft ||
      position == Alignment.bottomCenter ||
      position == Alignment.centerLeft ||
      position == Alignment.center;

  BorderRadius buildBorderRadius(double radius) => BorderRadius.only(
        bottomLeft: (_showBottomLeft) ? Radius.circular(radius) : Radius.zero,
        bottomRight: (_showBottomRight) ? Radius.circular(radius) : Radius.zero,
        topLeft: (_showTopLeft) ? Radius.circular(radius) : Radius.zero,
        topRight: (_showTopRight) ? Radius.circular(radius) : Radius.zero,
      );
}

class NotchPosition extends Alignment {
  const NotchPosition._() : super(0, 0);

  /// The top left corner.
  const NotchPosition.topLeft() : super(-1, -1);

  /// The center point along the top edge.
  const NotchPosition.topCenter() : super(0.0, -1.0);

  /// The top right corner.
  const NotchPosition.topRight() : super(1.0, -1.0);

  /// The center point along the left edge.
  const NotchPosition.centerLeft() : super(-1.0, 0.0);

  /// The center point, both horizontally and vertically.
  const NotchPosition.center() : super(0.0, 0.0);

  /// The center point along the right edge.
  const NotchPosition.centerRight() : super(1.0, 0.0);

  /// The bottom left corner.
  const NotchPosition.bottomLeft() : super(-1.0, 1.0);

  /// The center point along the bottom edge.
  const NotchPosition.bottomCenter() : super(0.0, 1.0);

  /// The bottom right corner.
  const NotchPosition.bottomRight() : super(1.0, 1.0);
}
