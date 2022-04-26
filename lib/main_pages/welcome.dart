import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> imagesList = [
    'assets/welcomePictures/filter.png',
    'assets/welcomePictures/zoomedfilter.png'
  ];
  List<String> imagesDescription = ['filter piece one', 'filter piece two'];
  int currentImage = 0;
  late String currentImageUrl;

  @override
  void initState() {
    super.initState();
    currentImageUrl = imagesList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Welcome to LIFE"),
        Row(
          children: [
            const Text('Hi I\'m Tita'),
            Image.asset(imagesList[currentImage]),
            Column(
              children: [
                Text(imagesDescription[currentImage]),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          if (currentImage > 0) {
                            setState(() {
                              currentImage--;
                            });
                          } else {
                            null;
                          }
                        },
                        child: const Text('left')),
                    TextButton(
                        onPressed: () {
                          if (currentImage < 1) {
                            setState(() {
                              currentImage++;
                            });
                          } else {
                            null;
                          }
                        },
                        child: const Text('right'))
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
