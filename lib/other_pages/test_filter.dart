import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/components/outlined_button.dart';

class TestFilter extends StatefulWidget {
  const TestFilter({Key? key}) : super(key: key);

  @override
  State<TestFilter> createState() => _TestFilterState();
}

class _TestFilterState extends State<TestFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: secondaryAppBar(context, 'Test Filter'),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text('Filter',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20)),
                        const SizedBox(height: 4),
                        const Text('Hands on experimentation'),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          width: 290,
                          child: Text('Guides',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20)),
                        ),
                        const SizedBox(height: 25),
                        outlinedButton(
                          context,
                          text: 'First Time',
                          path: '/',
                          height: 110,
                        ),
                        const SizedBox(height: 20),
                        outlinedButton(
                          context,
                          text: 'Refilling/Maintanence',
                          path: '/',
                          height: 110,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const AppColors().shadowColor,
                                  offset: const Offset(6, 6),
                                  blurRadius: 12,
                                  spreadRadius: 3,
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            width: 600,
                            height: 110,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/');
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const AppColors().buttonBlue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))),
                                child: const Center(
                                    child: Text(
                                  'Run Filter',
                                  style: TextStyle(color: Colors.white),
                                )))),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 600,
                          height: 240,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const AppColors().lightBlue,
                                    width: 3,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Column(children: [
                                  const Text('Connect Filter',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20)),
                                  const SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [const Text('Device Status')]),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          '*Teacher supervision advised'),
                                      Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const AppColors()
                                                    .shadowColor,
                                                offset: const Offset(6, 6),
                                                blurRadius: 12,
                                                spreadRadius: 3,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          width: 100,
                                          height: 20,
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('/');
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          const AppColors()
                                                              .buttonBlue),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ))),
                                              child: const Text(
                                                'Connect',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))),
                                    ],
                                  )
                                ]),
                              )),
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
