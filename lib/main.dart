import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

const MAPBOX_ACCESS_TOKEN = "MAPBOX ACCESS TOKEN HERE";

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            pinned: true,
            title: Text('SliverAppBar'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return index.isEven
                  ? Container(height: 120, child: PlatformViewWidget())
                  : Container(
                      height: 120,
                      child: Text('Text from Flutter'),
                    );
              },
              childCount: 1024,
            ),
          ),
        ],
      ),
    );
  }
}

class PlatformViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    if (Platform.isIOS) {
      return Row(children: [
        Expanded(child: UiKitView(
          viewType: "testView",
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        )),
        Expanded(child: MapWidget(
          resourceOptions: ResourceOptions(accessToken: MAPBOX_ACCESS_TOKEN),
        ))
      ]);
    }

    return Container();
  }
}