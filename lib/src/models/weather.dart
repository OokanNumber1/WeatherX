class Weather {
  const Weather({
    required this.condition,
    required this.temperature,
    required this.cityName,
  });
  final String cityName;
  final double temperature;
  final String condition;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      condition: json['weather'][0]['main'],
      temperature: json['main']['temp'],
      cityName: json['name'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        //other.timezone == timezone &&
        other.temperature == temperature &&
        other.condition == condition;
  }

  @override
  int get hashCode => temperature.hashCode ^ condition.hashCode;
}
