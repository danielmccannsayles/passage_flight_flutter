import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/components/outlined_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class ImageInfo {
  String title;
  String type;
  String description;
  String path;

  ImageInfo(this.title, this.type, this.description, this.path);
}

class _WelcomePageState extends State<WelcomePage> {
  List<ImageInfo> imagesList = [
    ImageInfo('Piece 1', 'Sensor', 'This is a sensor and piece #1',
        'assets/welcomePictures/filter.png'),
    ImageInfo('Piece 2', 'Motor', 'This is a motor and piece #2',
        'assets/welcomePictures/zoomedfilter.png'),
  ];
  int currentImage = 0;
  late String currentImageUrl;

  @override
  void initState() {
    super.initState();
    currentImageUrl = imagesList[0].path;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text("Welcome!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: const AppColors().textBlue,
                  fontSize: 20)),
          const SizedBox(height: 20),
          Expanded(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [
              outlinedButton(
                context,
                text: 'Why a Filter',
                path: '/testFilter',
              ),
              const SizedBox(height: 20),
              outlinedButton(context, text: 'How to Use', path: '/testFilter')
            ]),
            const SizedBox(
              width: 20,
            ),
            Image.asset(imagesList[currentImage].path, width: 290, height: 240),
            const SizedBox(
              width: 20,
            ),
            Column(children: [
              SizedBox(
                  width: 290,
                  height: 264,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const AppColors().lightBlue,
                          width: 3,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            imagesList[currentImage].title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 20),
                          Text('Type: ' + imagesList[currentImage].type),
                          const SizedBox(height: 20),
                          Text('What it does: ' +
                              imagesList[currentImage].description)
                        ]),
                  )),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentImage > 0) {
                        setState(() {
                          currentImage--;
                        });
                      } else {
                        null;
                      }
                    },
                    //TODO: fix this - remove splash since it doesnt clip
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Stack(children: [
                      Icon(
                        Icons.circle_outlined,
                        color: (currentImage == 0)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                      ),
                      Icon(
                        Icons.chevron_left,
                        color: (currentImage == 0)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                      )
                    ]),
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentImage < imagesList.length - 1) {
                        setState(() {
                          currentImage++;
                        });
                      } else {
                        null;
                      }
                    },
                    //TODO: fix this - remove splash since it doesnt clip
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Stack(children: [
                      Icon(
                        Icons.circle_outlined,
                        color: (currentImage == imagesList.length - 1)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: (currentImage == imagesList.length - 1)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                      )
                    ]),
                  ),
                ],
              )
            ])
          ]))
        ],
      ),
    );
  }
}
