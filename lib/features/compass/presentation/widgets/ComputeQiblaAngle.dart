import 'dart:math';

double computeQiblaAngle(double lat1, double lon1) {
  double lat2 = 21.4225; // Latitude of Kaaba
  double lon2 = 39.8262; // Longitude of Kaaba
  double deltaLon = lon2 - lon1;

  double y = sin(deltaLon) * cos(lat2);
  double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon);

  return (atan2(y, x) * 180 / pi + 360) % 360;
}
