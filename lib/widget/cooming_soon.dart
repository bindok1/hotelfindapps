import 'package:flutter/material.dart';
import 'package:hotelgo/config/app_asset.dart';

class CoomingSoon extends StatelessWidget {
  const CoomingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAsset.iconCoomingSoon,
            fit: BoxFit.fitHeight,
            height: 120,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Cooming Soon',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w900, color: Colors.black),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'We are developing this page\nfor new great feature',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
