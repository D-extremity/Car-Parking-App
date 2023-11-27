String getFare(String time, String vehicleType) {
  final parkedDate = DateTime.parse(time);
  final currentTime = DateTime.now();
  final difference = currentTime.difference(parkedDate);
  if (vehicleType.startsWith("4")) {
    double fare = 30 * (difference.inHours / 3);
    return fare == 0 ? "30" : "$fare";
  } else if (vehicleType.startsWith("2")) {
    double fare = 20 * (difference.inHours / 3);
    return fare == 0 ? "20" : "$fare";
  } else {
    double fare = 5 * (difference.inHours / 3);
    return fare == 0 ? "5" : "$fare";
  }
}
