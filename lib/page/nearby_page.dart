import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hotelgo/config/app_asset.dart';
import 'package:hotelgo/config/app_color.dart';
import 'package:hotelgo/config/app_format.dart';
import 'package:hotelgo/config/app_route.dart';
import 'package:hotelgo/config/session.dart';
import 'package:hotelgo/controller/c_nearby.dart';
import 'package:hotelgo/model/property.dart';

class NearbyPage extends StatelessWidget {
  NearbyPage({super.key});
  final cNearby = Get.put(CNearby());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 24,
        ),
        header(context),
        SizedBox(
          height: 20,
        ),
        searchField(),
        SizedBox(
          height: 30,
        ),
        categories(),
        SizedBox(
          height: 30,
        ),
        properties(),
      ],
    );
  }

  GetBuilder<CNearby> properties() {
    return GetBuilder<CNearby>(
      builder: (_) {
        //membuat filter data searching
        List<Property> list = _.category == 'All Place'
            ? _.listProperty
            : _.listProperty
                .where((e) => e.category == cNearby.category)
                .toList();
        if (list.isEmpty)
          return const Center(
            child: Text('Empty'),
          );
        return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Property property = list[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ApprRoute.detail,
                      arguments: property);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, index == 0 ? 0 : 8, 16,
                      index == list.length - 1 ? 16 : 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            property.cover!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
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
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Start from',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                      Text(
                                        AppFormat.currency(
                                            property.price!.toDouble()),
                                        style: TextStyle(
                                            color: AppColor.secondary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '/night',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: property.rate!,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star_rate_rounded,
                                color: AppColor.starActive,
                              ),
                              itemSize: 18,
                              unratedColor: AppColor.starInActive,
                              onRatingUpdate: (rating) {},
                              ignoreGestures: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  GetBuilder<CNearby> categories() {
    return GetBuilder<CNearby>(builder: (_) {
      return SizedBox(
        height: 45,
        child: ListView.builder(
          itemCount: _.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String category = _.categories[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 8, 0,
                  index == cNearby.categories.length - 1 ? 16 : 8, 0),
              child: Material(
                color: category == _.category ? AppColor.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    cNearby.category = category;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      category,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Container searchField() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              //untuk menghilangkan under line gunakan borderside none
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  hintText: 'Search by name or city',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(45),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(45),
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: Center(
                      child: ImageIcon(
                        AssetImage(
                          AppAsset.iconSearch,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(16, 16, 0, 0),
                items: [
                  PopupMenuItem(
                    child: Text('Logout'),
                    value: 'logout',
                  ),
                ],
              ).then((value) {
                if (value == 'logout') {
                  Session.clearUser();
                  Navigator.pushReplacementNamed(context, ApprRoute.signin);
                }
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                AppAsset.profile,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'Near Me',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                '100++',
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
