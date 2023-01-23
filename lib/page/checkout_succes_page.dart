import 'package:flutter/material.dart';
import 'package:hotelgo/controller/c_home.dart';
import 'package:hotelgo/model/property.dart';
import 'package:hotelgo/page/home_page.dart';
import 'package:hotelgo/widget/button_custom.dart';
import 'package:get/get.dart';

class CheckOutSucccesPage extends StatelessWidget {
  const CheckOutSucccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cHome = Get.put(CHome());
    Property property = ModalRoute.of(context)!.settings.arguments as Property;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 6, color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                property.cover!,
                width: 190,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 46,
          ),
          Text(
            'Payment Success',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Enjoy your a whole new experience\nin this beatiful world',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 46,
          ),
          ButtonCustom(
            label: 'View My Booking',
            onTap: () {
              cHome.indexPage = 1;
              Get.offAll(() => HomePage());
            },
            isExpand: false,
          )
        ],
      ),
    );
  }
}
