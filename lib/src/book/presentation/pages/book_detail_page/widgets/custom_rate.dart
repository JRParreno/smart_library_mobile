import 'package:flutter/material.dart';

class CustomRate extends StatelessWidget {
  /// Allows half a start to be selectable, like 2.5 stars. Defaults to `false`
  final bool allowHalf;

  /// Allows clearing if clicked in the same points. Defaults to `true`
  final bool allowClear;

  /// If read only, click is blocked
  final bool readOnly;

  /// Size of the icon
  final double iconSize;

  /// Color of the icon
  final Color color;

  /// Initial value, defaults to `0`
  final double initialValue;

  /// Function called whenever the rating changes
  final void Function(double value)? onChange;

  const CustomRate({
    Key? key,
    required this.allowHalf,
    required this.allowClear,
    required this.readOnly,
    required this.iconSize,
    required this.color,
    required this.initialValue,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStar(0),
        _buildStar(1),
        _buildStar(2),
        _buildStar(3),
        _buildStar(4),
      ],
    );
  }

  Widget _buildStar(int index) {
    var icon = _defaultIconBuilder(index);

    return icon;
  }

  Icon _defaultIconBuilder(int index) {
    var icon = initialValue > index.toDouble() ? Icons.star : Icons.star_border;

    if (initialValue == (index + 0.5)) {
      icon = Icons.star_half;
    }

    return Icon(icon, size: iconSize, color: color);
  }
}
