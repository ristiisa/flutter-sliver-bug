import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: SafeArea(child: HomeScreen()),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: getSlivers(),
        ),
      ),
    );
  }

  // Returns a list of slivers containing a pinned SliverAppBar and Platform View Widgets
  List<Widget> getSlivers() {
    final appBar = SliverAppBar(
      collapsedHeight: 80,
      forceElevated: true,
      backgroundColor: Colors.black,
      pinned: true,
      title: Text("Sliver App Bar"),
    );

    final bodySlivers = SliverList(
      delegate: SliverChildBuilderDelegate(
        (c, i) {
          if (i % 2 == 0) {
            return Container(height: 120, child: PlatformViewWidget());
          } else {
            return Container(
              height: 120,
              color: Colors.grey,
              child: Center(child: Text("Flutter Widget")),
            );
          }
        },
        childCount: 16,
      ),
    );

    return [appBar, SliverPersistentHeaderWidget(), bodySlivers];
  }
}

class SliverPersistentHeaderWidget extends StatefulWidget {
  const SliverPersistentHeaderWidget({Key? key}) : super(key: key);

  @override
  _SliverPersistentHeaderWidgetState createState() =>
      _SliverPersistentHeaderWidgetState();
}

class _SliverPersistentHeaderWidgetState
    extends State<SliverPersistentHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        Container(
          width: double.infinity,
          height: 80,
          color: Colors.amber,
          child: Center(child: Text("Sliver Persistent Header")),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate(this.child);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class PlatformViewWidget extends StatefulWidget {
  const PlatformViewWidget({Key? key}) : super(key: key);

  @override
  _PlatformViewWidgetState createState() => _PlatformViewWidgetState();
}

class _PlatformViewWidgetState extends State<PlatformViewWidget> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    if (Platform.isIOS) {
      return UiKitView(
        viewType: "testView",
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Container();
  }
}
