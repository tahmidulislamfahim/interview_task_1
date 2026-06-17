class Airport {
  final String? code;
  final String? name;
  final String? city;
  final String? country;

  Airport({
     this.code,
     this.name,
     this.city,
     this.country,
  });

  factory Airport.fromJson(String key, Map<String, dynamic> json) {
    return Airport(
      code: json['code'] ?? key,
      name: json['airport_name'] ?? '',
      city: json['airport_city'] ?? '',
      country: json['airport_country'] ?? '',
    );
  }

  String get fullName => "$name, $city";
}
