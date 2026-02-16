import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../../utils/date_time_util.dart';
import 'ride_pref_input_tile.dart';
import 'location_picker_screen.dart';
import 'seat_spinner.dart';

class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void _onSwapLocation() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  Future<void> _onDeparturePressed() async {
    final location = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (ctx) => LocationPickerScreen(initLocation: departure),
      ),
    );
    if (location != null) {
      setState(() {
        departure = location;
      });
    }
  }

  Future<void> _onArrivalPressed() async {
    final location = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (ctx) => LocationPickerScreen(initLocation: arrival),
      ),
    );
    if (location != null) {
      setState(() {
        arrival = location;
      });
    }
  }

  Future<void> _onSeatsPressed() async {
    final int? newSeats = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (ctx) => SeatSpinner(initialValue: requestedSeats),
      ),
    );
    if (newSeats != null) {
      setState(() {
        requestedSeats = newSeats;
      });
    }
  }
  

  Future<void> _onDatePressed() async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (newDate != null) {
      setState(() {
        departureDate = newDate;
      });
    }
  }

  void _onSearchPressed() {
    if (departure == null || arrival == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select both departure and arrival locations',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newRidePref = RidePref(
      departure: departure!,
      departureDate: departureDate,
      arrival: arrival!,
      requestedSeats: requestedSeats,
    );

    print("Search triggered with: $newRidePref");
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get _departureLabel => departure?.name ?? "Leaving from";
  String get _arrivalLabel => arrival?.name ?? "Going to";
  String get _dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get _seatsLabel => requestedSeats.toString();

  bool get _isDeparturePlaceholder => departure == null;
  bool get _isArrivalPlaceholder => arrival == null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  Widget _buildLocationInputs() {
    return Column(
      children: [
        RidePrefInputTile(
          icon: Icons.radio_button_off_outlined,
          label: _departureLabel,
          isPlaceholder: _isDeparturePlaceholder,
          onTap: _onDeparturePressed,
          rightIcon: IconButton(
            onPressed: _onSwapLocation,
            icon: Icon(Icons.swap_vert, color: BlaColors.primary),
          ),
        ),
        const Divider(height: 1, thickness: 0.5),
        RidePrefInputTile(
          icon: Icons.radio_button_off_outlined,
          label: _arrivalLabel,
          isPlaceholder: _isArrivalPlaceholder,
          onTap: _onArrivalPressed,
        ),
      ],
    );
  }

  Widget _buildDateInput() {
    return RidePrefInputTile(
      icon: Icons.calendar_month_outlined,
      label: _dateLabel,
      onTap: _onDatePressed,
    );
  }

  Widget _buildSeatsInput() {
    return RidePrefInputTile(
      icon: Icons.person_outline,
      label: _seatsLabel,
      onTap: _onSeatsPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.s),
          child: Column(
            children: [
              _buildLocationInputs(),
              const Divider(height: 1, thickness: 0.5),
              _buildDateInput(),
              const Divider(height: 1, thickness: 0.5),
              _buildSeatsInput(),
            ],
          ),
        ),

        SizedBox(height: BlaSpacings.m),

        BlaButton(
          label: "Search",
          onPressed: _onSearchPressed,
          type: BlaButtonType.primary,
        ),
      ],
    );
  }
}
