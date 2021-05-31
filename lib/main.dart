import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Animation opacityAnimation = Tween(begin: 0.5, end: 0.8).animate(_controller);
    final Animation heightAnimation = Tween(begin: 100.0, end: 150.0)
        .chain(CurveTween(curve: Curves.bounceOut))
        .chain(CurveTween(curve: Interval(0.2, 0.5)))
        .animate(_controller);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller, //每當_controller變化的時候, 就會呼叫一次builder
          builder: (BuildContext context, Widget child) {
            return Opacity(
              // opacity: Tween(begin: 0.5, end: 0.8).evaluate(_controller),
                 opacity: opacityAnimation.value,
              child: Container(
                width: 300,
                // height: 200 + 100 * _controller.value, //高度讓他200-300做變化
                // height: Tween(begin: 100.0, end: 200.0).evaluate(_controller),
                height: heightAnimation.value,
                color: Colors.blue,
                child: child,
              ),
            );
          },
          child: Center(//因為文字都沒有變化, 所以之後再做傳給builder裡面的child
            child: Text(
              "Hi",
              style: TextStyle(fontSize: 71),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
