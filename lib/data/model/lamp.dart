class Lamp {
  String? id;
  final int blue;
  final int green;
  final int red;
  final bool isRainbow;
  final bool isOn;

   Lamp({
    this.id,
    required this.blue,
    required this.green,
    required this.red,
    required this.isRainbow,
    required this.isOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Blue': blue,
      'Green': green,
      'Red': red,
      'Rainbow': isRainbow,
      'Power': isOn,
    };
  }

  factory Lamp.fromMap(Map<String, dynamic> map) {
    return Lamp(
      id: map['ID'],
      blue: map['Blue'],
      green: map['Green'],
      red: map['Red'],
      isRainbow: map['Rainbow'],
      isOn: map['Power'],
    );
  }
}