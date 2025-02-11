
class HijriDateModel {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;


  HijriDateModel({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,

  });

  factory HijriDateModel.fromJson(Map<String, dynamic> json) {
    return HijriDateModel(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': weekday.toJson(),
      'month': month.toJson(),
      'year': year,
    };
  }
}

class Weekday {
  final String en;
  final String ar;

  Weekday({
    required this.en,
    required this.ar,
  });

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(
      en: json['en'],
      ar: json['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}

class Month {
  final int number;
  final String en;
  final String ar;

  Month({
    required this.number,
    required this.en,
    required this.ar,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'en': en,
      'ar': ar,
    };
  }
}


