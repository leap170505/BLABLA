import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String label;
  final BlaButtonType type;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool disabled;
  const BlaButton({
    super.key,
    required this.label,
    this.type = BlaButtonType.primary,
    this.icon,
    this.onPressed,
    this.disabled = false,
  });

  bool get isDisabled => disabled || onPressed == null;

  Color _getButtonColor() {
    if (isDisabled) return BlaColors.disabled;
    switch (type) {
      case BlaButtonType.primary:
        return BlaColors.primary;
      case BlaButtonType.secondary:
        return BlaColors.backgroundAccent;
    }
  }

  Color _getTextColor() {
    if (isDisabled) {
      return BlaColors.disabled;
    } else {
      return BlaColors.textNormal;
    }
  }

  Color _getIconColor() {
    if (isDisabled) {
      return BlaColors.disabled;
    }

    return type == BlaButtonType.primary
        ? BlaColors.iconLight
        : BlaColors.iconNormal;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColor(),
        foregroundColor: _getTextColor(),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: icon == null 
      ? Text(
            label,
            textAlign: TextAlign.center,
            style: BlaTextStyles.button.copyWith(color: _getTextColor()),
          ) 
      : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: _getIconColor()),
          Text(
            label,
            textAlign: TextAlign.center,
            style: BlaTextStyles.button.copyWith(color: _getTextColor()),
          ),
        ],
      ),
    );
  }
}
