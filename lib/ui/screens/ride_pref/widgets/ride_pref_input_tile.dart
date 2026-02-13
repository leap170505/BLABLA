import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class RidePrefInputTile extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final bool isPlaceholder;
  final Widget? rightIcon;

  const RidePrefInputTile({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isPlaceholder = false,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m, vertical: BlaSpacings.m),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: BlaColors.neutralLight, size: 20),
            if (icon != null) const SizedBox(width: BlaSpacings.m),
            Expanded(
              child: Text(
                label,
                style: BlaTextStyles.body.copyWith(
                  color: isPlaceholder ? BlaColors.neutralLight : BlaColors.textNormal,
                ),
              ),
            ),
             ?rightIcon,
          ],
        ),
      ),
    );
  }
}
