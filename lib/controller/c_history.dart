import 'package:get/get.dart';
import 'package:hotelgo/model/booking.dart';
import 'package:hotelgo/model/property.dart';
import 'package:hotelgo/source/booking_source.dart';
import 'package:hotelgo/source/properties_source.dart';

class CHistory extends GetxController {
  final _listBooking = <Booking>[].obs;
  List<Booking> get listBooking => _listBooking.value;

  getListBooking(String id) async {
    _listBooking.value = await BookingSource.getHistory(id);
    update();
  }
}
