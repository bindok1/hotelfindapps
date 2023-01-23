import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelgo/model/property.dart';

class PropertiesSource {
  static Future<List<Property>> getProperty() async {
    var result = await FirebaseFirestore.instance.collection('property').get();
    return result.docs.map((e) => Property.fromJson(e.data())).toList();
  }
}
