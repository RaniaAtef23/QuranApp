class GregorianModel {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;

  GregorianModel({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  // Factory constructor to create a GregorianModel from JSON data
  factory GregorianModel.fromJson(Map<String, dynamic> json) {
    return GregorianModel(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
    );
  }

  // Convert GregorianModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': weekday.toJson(),
      'month': month.toJson(),
      'year': year,
      'designation': designation.toJson(),
    };
  }
}

class Weekday {
  final String en;

  Weekday({required this.en});

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(en: json['en']);
  }

  Map<String, dynamic> toJson() {
    return {'en': en};
  }
}

class Month {
  final int number;
  final String en;

  Month({required this.number, required this.en});

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(number: json['number'], en: json['en']);
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'en': en};
  }
}

class Designation {
  final String abbreviated;
  final String expanded;

  Designation({required this.abbreviated, required this.expanded});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abbreviated': abbreviated,
      'expanded': expanded,
    };
  }
}
