// Untuk memudahkan penulisan/pembuatan database, terutama espId dan nama
//Template atau blueprint untuk menyimpan data device
class Device {
  final String espId;
  final String name;
  final String location;

  Device({
    required this.espId, //Saat membuat classnya, wajib mengisi variabel
    required this.name,
    required this.location,
  });

  Map<String, dynamic> toJson() => { //Mengubah class device menjadi map untuk dimasukan ke Json
        'espId': espId,
        'name': name,
        'location': location,
      };

  factory Device.fromJson(Map<String, dynamic> json) => Device( //Mencetak class dari map yang diekstrak dari Json
        espId: json['espId'] as String,
        name: json['name'] as String,
        location: json['location'] as String,
      );
}