class MetaModel {
  final double latitude;
  final double longitude;
  final String timezone;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;


  MetaModel({
    required this.latitude,
    required this.longitude,
    required this.timezone,

    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,

  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],

      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
      midnightMode: json['midnightMode'],
      school: json['school'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,

      'latitudeAdjustmentMethod': latitudeAdjustmentMethod,
      'midnightMode': midnightMode,
      'school': school,

    };
  }
}
