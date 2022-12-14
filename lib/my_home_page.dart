import 'dart:core';

import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  final ValueChanged<bool> onChangeTheme;

  const MyInheritedWidget({
    super.key,
    required super.child,
    required this.onChangeTheme,
  });

  static MyInheritedWidget of(BuildContext context) {
    return context.findAncestorWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      onChangeTheme: (bool value) {
        _isDark = value;
        setState(() {});
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: _isDark ? ThemeData.dark() : ThemeData.light(),
        home: const MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Switch(
          value: _isDark,
          onChanged: (bool value) {
            _isDark = value;
            MyInheritedWidget.of(context).onChangeTheme(value);
            setState(() {});
          },
        ),
      ),
    );
  }
}
