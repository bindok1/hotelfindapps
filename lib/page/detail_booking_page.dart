import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:hotelgo/config/app_asset.dart';
import 'package:hotelgo/config/app_color.dart';
import 'package:hotelgo/config/app_format.dart';
import 'package:hotelgo/config/app_route.dart';
import 'package:hotelgo/controller/c_user.dart';
import 'package:hotelgo/model/booking.dart';
import 'package:hotelgo/model/property.dart';
import 'package:hotelgo/source/booking_source.dart';
import 'package:hotelgo/widget/button_custom.dart';
import 'package:intl/intl.dart';

class DetailBookingPage extends StatelessWidget {
  DetailBookingPage({Key? key}) : super(key: key);
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    //untuk menangkap navigator nya
    Booking booking = ModalRoute.of(context)!.settings.arguments as Booking;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Booking',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(booking, context),
          SizedBox(
            height: 16,
          ),
          roomDetails(booking, context),
          SizedBox(
            height: 16,
          ),
          paymentMethod(context),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[100]!),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppAsset.iconMasterCard,
                  width: 50,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nio Zihni',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Balance ${AppFormat.currency(1000)}',
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: AppColor.secondary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container roomDetails(Booking booking, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Details',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          itemRoomDetail(
            context,
            'Date',
            AppFormat.date(booking.date!),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(context, 'Guest', '${booking.guest}'),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            'Check-in Time',
            AppFormat.dateMonth(
              booking.date!,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            '1 month',
            AppFormat.currency(
              100,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            'OGO fee',
            AppFormat.currency(booking.serviceFee!.toDouble()),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            'Water',
            AppFormat.currency(10),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            'Electricity',
            AppFormat.currency(
              5,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            'Wifi',
            AppFormat.currency(
              12,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          itemRoomDetail(
            context,
            'Total Payment',
            AppFormat.currency(booking.totalPayment!.toDouble()),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Row itemRoomDetail(BuildContext context, String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold)),
        Text(
          data,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Container header(Booking booking, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.all(16),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            booking.cover!,
            fit: BoxFit.cover,
            height: 70,
            width: 90,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                booking.location!,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.w300),
              )
            ],
          ),
        )
      ]),
    );
  }
}
