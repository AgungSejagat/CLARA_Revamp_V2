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

  Future<Lamp> getLampById(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();

    return Lamp.fromMap(doc.data()!);
  }

  Future<bool> isExist(String id) async {
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

  Future<Lamp> updateLamp(Lamp lamp) async {
    await _firestore.collection(_collection).doc(lamp.id).update(lamp.toMap());
  
    return lamp;
  }
}
