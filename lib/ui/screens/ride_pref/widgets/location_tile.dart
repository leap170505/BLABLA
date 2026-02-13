import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

///
/// Tile to display a location in the list.
///
class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onPressed;

  const LocationTile({
    super.key,
    required this.location,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        location.name,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label.copyWith(color: BlaColors.neutralLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: BlaColors.neutralLight,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: BlaSpacings.xl),
    );
  }
}
