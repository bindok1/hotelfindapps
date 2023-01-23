import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hotelgo/config/app_asset.dart';
import 'package:hotelgo/config/app_color.dart';
import 'package:hotelgo/config/app_format.dart';
import 'package:hotelgo/config/app_route.dart';
import 'package:hotelgo/controller/c_user.dart';
import 'package:hotelgo/model/booking.dart';

import 'package:hotelgo/model/property.dart';
import 'package:hotelgo/source/booking_source.dart';
import 'package:hotelgo/widget/button_custom.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final cUser = Get.put(CUser());

  final Rx<Booking> _bookedData = initBooking.obs;
  Booking get bookedData => _bookedData.value;
  set bookedData(Booking n) => _bookedData.value = n;

  final List facilities = [
    {'icon': AppAsset.iconCoffee, 'label': 'Longue'},
    {'icon': AppAsset.iconOffice, 'label': 'Office'},
    {'icon': AppAsset.iconWifi, 'label': 'Wi-Fi'},
    {'icon': AppAsset.iconStore, 'label': 'Store'},
  ];

  @override
  Widget build(BuildContext context) {
    //untuk mengambil model property
    Property property = ModalRoute.of(context)!.settings.arguments as Property;
    BookingSource.checkIsBooked(cUser.data.id!, property.id!)
        .then((bookingValue) {
      //kalau null kita pakai value kli tdk maka initBooking akan dipakai
      bookedData = bookingValue ?? initBooking;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // bottomNavigationBar: bookingNow(property, context),
      //pengecekan apakah sudah booked atau belum menggunakan Obx
      bottomNavigationBar: Obx(() {
        if (bookedData.id == '') return bookingNow(property, context);
        return viewReceipt(bookedData, context);
      }),

      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 24,
            ),
            images(property),
            SizedBox(
              height: 16,
            ),
            name(property, context),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(property.description!),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Facilites',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            GridFacilities(),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Activities',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 16,
            ),
            activities(property),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Container viewReceipt(BuildContext, context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 1.5),
        ),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You booked this',
            style: TextStyle(color: Colors.grey),
          ),
          Material(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.secondary,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pushNamed(context, ApprRoute.detailBooking,
                    arguments: bookedData);
              },
              child: const Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: const Text(
                  'View Receipt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container bookingNow(Property property, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 1.5),
        ),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppFormat.currency(
                    property.price!.toDouble(),
                  ),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.secondary, fontWeight: FontWeight.w900),
                ),
                const Text(
                  'per night',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          ButtonCustom(
            label: 'Booking Now',
            onTap: () {
              Navigator.pushNamed(context, ApprRoute.checkout,
                  arguments: property);
            },
          )
        ],
      ),
    );
  }

  SizedBox activities(Property property) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        itemCount: property.activities.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Map activity = property.activities[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 8, 0,
                index == property.activities.length - 1 ? 16 : 8, 0),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      activity['image'],
                      width: 100,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 6,
                ),
                Text(activity['name']),
              ],
            ),
          );
        },
      ),
    );
  }

  GridView GridFacilities() {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      itemCount: facilities.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //bisa langgsung memanggil list dengan nama dengn property nya dengan kata
              //kunci
              ImageIcon(AssetImage(facilities[index]['icon'])),
              const SizedBox(
                height: 4,
              ),
              Text(
                facilities[index]['label'],
                style: const TextStyle(fontSize: 13),
              )
            ],
          ),
        );
      },
    );
  }

  Padding name(Property property, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  property.location!,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: AppColor.starActive,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            property.rate.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  SizedBox images(Property property) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: property.images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 8, 0,
                  index == property.images.length - 1 ? 8 : 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  property.images[index],
                  fit: BoxFit.cover,
                  height: 100,
                  width: 240,
                ),
              ),
            );
          }),
    );
  }
}
