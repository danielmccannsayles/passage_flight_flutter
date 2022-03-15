import 'package:flutter/material.dart';

import 'background_collecting_task.dart';
import './helpers/LineChart.dart';
import './helpers/PaintStyle.dart';

class BackgroundCollectedPage extends StatefulWidget {
  const BackgroundCollectedPage({Key? key}) : super(key: key);

  @override
  State<BackgroundCollectedPage> createState() =>
      _BackgroundCollectedPageState();
}

class _BackgroundCollectedPageState extends State<BackgroundCollectedPage> {
  //how much of the data is shown
  Duration _duration1 = const Duration(hours: 1);

  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);

    // Arguments shift is needed for timestamps as miliseconds in double could loose precision.
    final int argumentsShift =
        task.samples.first.timestamp.millisecondsSinceEpoch;

    const Duration showDuration =
        Duration(hours: 1); // @TODO . show duration should be configurable
    final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);

    final Iterable<double> arguments = lastSamples.map((sample) {
      return (sample.timestamp.millisecondsSinceEpoch - argumentsShift)
          .toDouble();
    });

    // Step for argument labels
    const Duration argumentsStep =
        Duration(minutes: 10); // @TODO . step duration should be configurable

    // Find first timestamp floored to step before
    final DateTime beginningArguments = lastSamples.first.timestamp;
    DateTime beginningArgumentsStep = DateTime(beginningArguments.year,
        beginningArguments.month, beginningArguments.day);
    while (beginningArgumentsStep.isBefore(beginningArguments)) {
      beginningArgumentsStep = beginningArgumentsStep.add(argumentsStep);
    }
    beginningArgumentsStep = beginningArgumentsStep.subtract(argumentsStep);
    final DateTime endingArguments = lastSamples.last.timestamp;

    // Generate list of timestamps of labels
    final Iterable<DateTime> argumentsLabelsTimestamps = () sync* {
      DateTime timestamp = beginningArgumentsStep;
      yield timestamp;
      while (timestamp.isBefore(endingArguments)) {
        timestamp = timestamp.add(argumentsStep);
        yield timestamp;
      }
    }();

    // Map strings for labels
    final Iterable<LabelEntry> argumentsLabels =
        argumentsLabelsTimestamps.map((timestamp) {
      return LabelEntry(
          (timestamp.millisecondsSinceEpoch - argumentsShift).toDouble(),
          ((timestamp.hour <= 9 ? '0' : '') +
              timestamp.hour.toString() +
              ':' +
              (timestamp.minute <= 9 ? '0' : '') +
              timestamp.minute.toString()));
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Collected data'),
          actions: <Widget>[
            // Progress circle
            (task.inProgress
                ? FittedBox(
                    child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))))
                : Container(/* Dummy */)),
            // Start/stop buttons
            (task.inProgress
                ? IconButton(
                    icon: const Icon(Icons.pause), onPressed: task.pause)
                : IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: task.reasume)),
          ],
        ),
        body: ListView(
          children: <Widget>[
            const Divider(),
            ListTile(
                leading: const Icon(Icons.brightness_7),
                title: const Text('1st Sensor'),
                subtitle: Slider(
                  label: '${_duration1.inHours}',
                  divisions: 4,
                  min: 1,
                  max: 5,
                  value: _duration1.inHours.toDouble(),
                  onChanged: (value) => {
                    setState(() {
                      _duration1 = Duration(hours: value.toInt());
                    })
                  },
                )),
            LineChart(
              constraints: const BoxConstraints.expand(height: 350),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.temperature1),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: const [
                null,
                //const PaintStyle(style: PaintingStyle.stroke, strokeWidth: 1.7*3, color: Colors.indigo, strokeCap: StrokeCap.round),
              ],
              seriesLinesStyles: const [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.redAccent),
              ],
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.brightness_7),
              title: Text('2nd Sensor'),
              subtitle: Text('subtitle'),
            ),
            LineChart(
              constraints: const BoxConstraints.expand(height: 350),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.temperature2),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: const [
                null,
                //const PaintStyle(style: PaintingStyle.stroke, strokeWidth: 1.7*3, color: Colors.indigo, strokeCap: StrokeCap.round),
              ],
              seriesLinesStyles: const [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.indigoAccent),
              ],
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.filter_vintage),
              title: Text('Testing stuff'),
            ),
            Text("Bool 1",
                style: TextStyle(
                    color: lastSamples.last.waterpHlevel.toInt() % 2 == 0
                        ? Colors.green
                        : Colors.red))
          ],
        ));
  }
}
