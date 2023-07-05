import 'package:latlong2/latlong.dart';

class AppConstants {
  static const mapBoxUrlTemplate =
      'https://api.mapbox.com/styles/v1/sherifalsayed/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}';
  static const String mapBoxAccessToken =
      'pk.eyJ1Ijoic2hlcmlmYWxzYXllZCIsImEiOiJjbGdxeXNtdzMxZWhmM2VtbTRsdW8xZmJiIn0.CtX0zolXMYV0DsJ6tZIQXQ';

  static const String mapBoxStyleId = 'clgqz2puy000601r0gxkl1jpw';

  static final startLocation = LatLng(48.1481406, 11.4612251);
  static const dataJsonPath = 'assets/data.json';
}
