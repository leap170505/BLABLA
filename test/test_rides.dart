import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
    test('filterBy with both criteria returns correct ride', () {
      final departure = Location(name: "Dijon", country: Country.france);
      final result = RidesService.filterBy(
        departure: departure,
        seatRequested: 2,
      );
      for (Ride ride in result ) {
      print(ride);
    }
      expect(result.length, 1);
    });
}
