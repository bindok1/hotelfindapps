import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:hotelgo/config/app_asset.dart';
import 'package:hotelgo/config/app_color.dart';
import 'package:hotelgo/controller/c_home.dart';
import 'package:hotelgo/page/history_page.dart';
import 'package:hotelgo/page/nearby_page.dart';
import 'package:hotelgo/widget/cooming_soon.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final cHome = Get.put(CHome());
  final List<Map> listNav = [
    {
      'icon': AppAsset.iconNearby,
      'label': 'Nearby',
    },
    {
      'icon': AppAsset.iconHistory,
      'label': 'History',
    },
    {
      'icon': AppAsset.iconPayment,
      'label': 'Payment',
    },
    {
      'icon': AppAsset.iconReward,
      'label': 'Reward',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cHome.indexPage == 0) {
          return NearbyPage();
        }
        if (cHome.indexPage == 1) {
          return HistoryPage();
        }
        return CoomingSoon();
      }),
      bottomNavigationBar: Obx(() {
        return Material(
          //elevation untuk membuat shadow
          elevation: 8,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 8, bottom: 6),
            child: BottomNavigationBar(
                currentIndex: cHome.indexPage,
                onTap: (value) => cHome.indexPage = value,
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                selectedIconTheme: const IconThemeData(color: AppColor.primary),
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                selectedFontSize: 12,
                items: listNav.map((e) {
                  return BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(e['icon'])),
                    label: e['label'],
                  );
                }).toList()),
          ),
        );
      }),
    );
  }
}
