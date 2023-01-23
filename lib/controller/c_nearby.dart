import 'package:get/get.dart';
import 'package:hotelgo/model/property.dart';
import 'package:hotelgo/source/properties_source.dart';

class CNearby extends GetxController {
  final _category = 'All Place'.obs;

  String get category => _category.value;
  set category(n) {
    _category.value = n;
    update();
  }

  List<String> get categories => ['All Place', 'Industrial', 'Village'];

  final _listProperty = <Property>[].obs;
  List<Property> get listProperty => _listProperty.value;

  getListProperty() async {
    _listProperty.value = await PropertiesSource.getProperty();
    update();
  }

//buat fungsi agar dieksekusi ketika di widget dibuka
  @override
  void onInit() {
    getListProperty();
    super.onInit();
  }
}
