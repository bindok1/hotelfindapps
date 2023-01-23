import 'package:flutter/material.dart';
import 'package:hotelgo/config/app_asset.dart';
import 'package:hotelgo/config/app_route.dart';
import 'package:hotelgo/widget/button_custom.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      //stackfit.expand agar membuat gambar satu screen penuh
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAsset.bgIntro,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
              //gradient untuk membuat gradasi
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent])),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                horizontal: 30,
              )),
              Text('Your Great Life\nStarts Here',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w900)),
              SizedBox(
                height: 10,
              ),
              Text('More than just a home',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w300)),
              SizedBox(
                height: 50,
              ),
              ButtonCustom(
                label: 'Get Started',
                onTap: () {
                  Navigator.pushReplacementNamed(context, ApprRoute.signin);
                },
                isExpand: true,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
