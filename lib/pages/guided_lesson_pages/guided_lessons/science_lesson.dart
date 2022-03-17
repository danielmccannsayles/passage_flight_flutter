import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import '../../../components/custom_app_bar.dart';

import 'dart:developer';

class ScienceLesson extends StatefulWidget {
  const ScienceLesson({Key? key}) : super(key: key);

  @override
  State<ScienceLesson> createState() => ScienceLessonState();
}

class ScienceLessonState extends State<ScienceLesson> {
  final ScrollController _scrollController = ScrollController();

  double _scrollPosition = 0;

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients) {
        _scrollController.addListener(() {
          setState(() {
            _scrollPosition = _scrollController.position.pixels;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Science Lesson One'),
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Go Home'),
            ),
            const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan libero a lacinia fermentum. Mauris ac tellus et ante fringilla faucibus. Quisque hendrerit odio non magna posuere, sed accumsan nisi rutrum. Suspendisse quis tempor magna. Nullam velit elit, lobortis elementum molestie et, hendrerit ultricies magna. Etiam est leo, bibendum nec feugiat sed, varius in sem. Morbi imperdiet gravida libero, euismod eleifend nisl interdum ut. In nec est turpis. Duis commodo turpis nulla, at tempor felis vehicula nec. Nulla libero velit, mollis ac risus ac, fringilla luctus urna. Integer dapibus efficitur facilisis. Nullam malesuada turpis et lorem vehicula varius. Aliquam luctus, nisi sed dictum vulputate, risus nulla tempor felis, sit amet mattis ante purus quis enim. Fusce malesuada et orci non ullamcorper. Vivamus vel urna ipsum. Praesent eget vestibulum justo. Aenean luctus risus dui, lobortis dapibus nisl vulputate nec. Cras iaculis neque eget porta lobortis. Etiam in mi at dui finibus venenatis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas varius metus eu ipsum pretium molestie nec et ante. Aliquam pharetra metus in ornare tincidunt. Donec bibendum efficitur purus sit amet pretium. Nam quis bibendum sapien. Aenean fermentum venenatis felis, in tristique turpis imperdiet vitae. Sed venenatis pretium elementum. Morbi vehicula convallis laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla fringilla suscipit est, eu lobortis ex faucibus sed. Curabitur nisi nulla, consectetur et dignissim euismod, porttitor efficitur purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam congue, nulla sed sollicitudin posuere, ipsum velit tempus mi, sed fermentum dolor tellus quis sem. In sagittis nisl non quam blandit feugiat. Mauris a ex eu nibh vestibulum ornare sed nec massa. Praesent rutrum mollis tortor. Aenean urna erat, semper eu lorem ut, sollicitudin condimentum massa. Donec mollis eros vitae nunc consectetur, at pretium ante varius. Aliquam nec varius dolor. Mauris sollicitudin tortor sed magna pellentesque molestie. Proin enim urna, maximus eu imperdiet non, vehicula sit amet quam. Sed feugiat, ligula ac feugiat venenatis, nisl arcu accumsan mauris, non lobortis velit dui sit amet diam. Cras eget turpis placerat, euismod ex at, condimentum sapien. Nam scelerisque viverra lorem, molestie finibus erat auctor vitae. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam fringilla molestie nulla eget suscipit. Aliquam sit amet leo dui. Pellentesque laoreet turpis vitae urna bibendum, non accumsan nunc tristique. Mauris at ipsum sit amet ipsum laoreet venenatis. Donec id orci vel ante ultrices varius at id urna. Nulla aliquam est sed diam sagittis, in facilisis est fermentum. Etiam luctus bibendum diam, id ultrices lacus ornare vitae.'),
            const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan libero a lacinia fermentum. Mauris ac tellus et ante fringilla faucibus. Quisque hendrerit odio non magna posuere, sed accumsan nisi rutrum. Suspendisse quis tempor magna. Nullam velit elit, lobortis elementum molestie et, hendrerit ultricies magna. Etiam est leo, bibendum nec feugiat sed, varius in sem. Morbi imperdiet gravida libero, euismod eleifend nisl interdum ut. In nec est turpis. Duis commodo turpis nulla, at tempor felis vehicula nec. Nulla libero velit, mollis ac risus ac, fringilla luctus urna. Integer dapibus efficitur facilisis. Nullam malesuada turpis et lorem vehicula varius. Aliquam luctus, nisi sed dictum vulputate, risus nulla tempor felis, sit amet mattis ante purus quis enim. Fusce malesuada et orci non ullamcorper. Vivamus vel urna ipsum. Praesent eget vestibulum justo. Aenean luctus risus dui, lobortis dapibus nisl vulputate nec. Cras iaculis neque eget porta lobortis. Etiam in mi at dui finibus venenatis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas varius metus eu ipsum pretium molestie nec et ante. Aliquam pharetra metus in ornare tincidunt. Donec bibendum efficitur purus sit amet pretium. Nam quis bibendum sapien. Aenean fermentum venenatis felis, in tristique turpis imperdiet vitae. Sed venenatis pretium elementum. Morbi vehicula convallis laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla fringilla suscipit est, eu lobortis ex faucibus sed. Curabitur nisi nulla, consectetur et dignissim euismod, porttitor efficitur purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam congue, nulla sed sollicitudin posuere, ipsum velit tempus mi, sed fermentum dolor tellus quis sem. In sagittis nisl non quam blandit feugiat. Mauris a ex eu nibh vestibulum ornare sed nec massa. Praesent rutrum mollis tortor. Aenean urna erat, semper eu lorem ut, sollicitudin condimentum massa. Donec mollis eros vitae nunc consectetur, at pretium ante varius. Aliquam nec varius dolor. Mauris sollicitudin tortor sed magna pellentesque molestie. Proin enim urna, maximus eu imperdiet non, vehicula sit amet quam. Sed feugiat, ligula ac feugiat venenatis, nisl arcu accumsan mauris, non lobortis velit dui sit amet diam. Cras eget turpis placerat, euismod ex at, condimentum sapien. Nam scelerisque viverra lorem, molestie finibus erat auctor vitae. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam fringilla molestie nulla eget suscipit. Aliquam sit amet leo dui. Pellentesque laoreet turpis vitae urna bibendum, non accumsan nunc tristique. Mauris at ipsum sit amet ipsum laoreet venenatis. Donec id orci vel ante ultrices varius at id urna. Nulla aliquam est sed diam sagittis, in facilisis est fermentum. Etiam luctus bibendum diam, id ultrices lacus ornare vitae.')
          ])),
    );
  }
}
