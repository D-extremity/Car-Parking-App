import 'package:parking_system/pages/homepage.dart';

String getFare(String time, String vehicleType) {
  final parkedDate = DateTime.parse(time);
  final currentTime = DateTime.now();
  final difference = currentTime.difference(parkedDate);
  if (vehicleType.startsWith("4")) {
    double fare = car * (difference.inHours / 3);
    return fare == 0 ? "30" : fare.toString().substring(0,3);
  } else if (vehicleType.startsWith("2")) {
    double fare = bike * (difference.inHours / 3);
    return fare == 0 ? "20" : fare.toString().substring(0,3);
  } else {
    double fare = cycle * (difference.inHours / 3);
    return fare == 0 ? "5" : fare.toString().substring(0,3);
  }
}
