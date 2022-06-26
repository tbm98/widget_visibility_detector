import 'package:flutter/material.dart';
import 'package:widget_visibility_detector/widget_visibility_detector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  List<Widget> get _page => [_page1(), _page2()];

  @override
  Widget build(BuildContext context) {
    return WidgetVisibilityDetector(
      onAppear: () {
        print('page1 onAppear');
      },
      onDisappear: () {
        print('page1 onDisappear');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: IndexedStack(
          index: index,
          children: _page,
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                print('hihi');
                setState(() {
                  index = 1;
                });
              },
              child: Icon(Icons.subdirectory_arrow_left),
            ),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: '3',
              onPressed: () {
                // setState(() {
                //   index = 0;
                // });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Page2();
                }));
              },
              child: Icon(Icons.ac_unit),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _page1() {
    return WidgetVisibilityDetector(
      onAppear: () {
        print('tab1 onAppear');
      },
      onDisappear: () {
        print('tab1 onDisappear');
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('tab1'),
            ],
          ),
        )),
      ),
    );
  }

  Widget _page2() {
    return WidgetVisibilityDetector(
      onAppear: () {
        print('tab2 onAppear');
      },
      onDisappear: () {
        print('tab2 onDisappear');
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Container(
          child: Text('tab2'),
        )),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return WidgetVisibilityDetector(
      onAppear: () {
        print('page2 onAppear');
      },
      onDisappear: () {
        print('page2 onDisappear');
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Text('page2'),
        ),
      ),
    );
  }
}
