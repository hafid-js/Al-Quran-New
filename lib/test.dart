// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const numberOfItems = 5001;
const scrollDuration = Duration(seconds: 2);


void main() {
  runApp(TestScreen());
}

// The root widget for the example app.
class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrollablePositionedList Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScrollablePositionedListPage(),
    );
  }
}
class ScrollablePositionedListPage extends StatefulWidget {
  const ScrollablePositionedListPage({Key? key}) : super(key: key);

  @override
  _ScrollablePositionedListPageState createState() =>
      _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState
    extends State<ScrollablePositionedListPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  double alignment = 0.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: OrientationBuilder(
          builder: (context, orientation) => Column(
            children: <Widget>[
              Expanded(
                child: ScrollablePositionedList.builder(
        itemCount: numberOfItems,
        itemBuilder: (context, index) => Container(
        child: Center(
          child: Text('Item $index'),
        ),
      ),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetController: scrollOffsetController,
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
      ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      scrollControlButtons,
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );



  Widget get scrollControlButtons => Row(
        children: <Widget>[
          const Text('scroll to'),
          scrollItemButton(10),
          scrollItemButton(100),
        ],
      );

  Widget scrollItemButton(int value) => TextButton(
        key: ValueKey<String>('Scroll$value'),
        onPressed: () => scrollTo(value),
        child: Text('$value'),

      );

 

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);
}