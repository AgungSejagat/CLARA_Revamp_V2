//Mengupdate dan mengambil data-data lampu yang ada di firestore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clara_v1/data/model/lamp.dart';

class LampRepository {
  static final LampRepository _instance = LampRepository._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'Neopixel';

  factory LampRepository() {
    return _instance;
  }

  LampRepository._();

  Future<Lamp> getLampById(String id) async {  //Mengambil data lampu dengan id tertentu
    final doc = await _firestore.collection(_collection).doc(id).get();

    return Lamp.fromMap(doc.data()!);
  }

  Stream<Lamp>  streamLampById(String id) {
    return _firestore.collection(_collection).doc(id).snapshots().map((event) => Lamp.fromMap(event.data()!));
  }

  Future<bool> isExist(String id) async { //Mengecek apakah lampu dengan id tertentu ada di firestore
    try {
      bool isExist = false;
      await _firestore.collection(_collection).doc(id).get().then((value) {
        isExist = value.exists;
      });
      return isExist;
    } catch (e) {
      return false;
    }
  }

  Future<Lamp> updateLamp(Lamp lamp) async { //Mengupdate data lampu
    await _firestore.collection(_collection).doc(lamp.id).update(lamp.toMap());
  
    return lamp;
  }
}
