import 'package:flutter/material.dart';
import '../../../../dummy_data/dummy_data.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';
import 'location_tile.dart';


class LocationPickerScreen extends StatefulWidget {
  final Location? initLocation;

  const LocationPickerScreen({super.key, this.initLocation});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  List<Location> filteredLocations = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredLocations = fakeLocations; 
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredLocations = fakeLocations
          .where((location) =>
              location.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }
  
  void _onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }
  
  void _onBack() {
    Navigator.of(context).pop();
  }
  
  void _onClearSearch() {
     _searchController.clear();
     _onSearchChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
                return Column(
                  children: [
                    LocationTile(
                      location: location,
                      onPressed: () => _onLocationSelected(location),
                    ),
                     const Divider(height: 1, thickness: 0.5, indent: BlaSpacings.l, endIndent: BlaSpacings.l),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + BlaSpacings.s,
        left: BlaSpacings.m,
        right: BlaSpacings.m,
        bottom: BlaSpacings.s,
      ),
      decoration: BoxDecoration(
        color: BlaColors.white,
      ),
      child: Row(
        children: [
            IconButton(
              onPressed: _onBack,
              icon: Icon(Icons.arrow_back_ios, color: BlaColors.neutralLight, size: 20),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.s),
              decoration: BoxDecoration(
                color: BlaColors.backgroundAccent,
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
                decoration: InputDecoration(
                  hintText: "City",
                  hintStyle: BlaTextStyles.body.copyWith(color: BlaColors.neutralLight),
                  border: InputBorder.none,
                  icon: null,
                  suffixIcon: _searchController.text.isNotEmpty 
                  ? IconButton(onPressed: _onClearSearch, icon: Icon(Icons.close, color: BlaColors.neutralLight, size: 16))
                  : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
