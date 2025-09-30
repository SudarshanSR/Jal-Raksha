import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator.dart';
import 'dashboard.dart';
import 'map.dart';

void main() {
  runApp(JalRaksha());
}

class JalRaksha extends StatelessWidget {
  const JalRaksha({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JalRakshaState(),
      child: MaterialApp(
        title: 'Jal Raksha',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: Home(),
      ),
    );
  }
}

class JalRakshaState extends ChangeNotifier {}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedIndex = 0;

  List<Widget> pages = [
    DashBoardPage(),
    CalculatorPage(),
    MapParentWidget(),
    ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.water_drop),
            title: const Text("Jal Raksha"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
                tooltip: 'Settings',
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info),
                tooltip: 'About',
              ),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.calculate),
                label: 'HMPI Calc',
              ),
              NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
              NavigationDestination(
                icon: Icon(Icons.analytics),
                label: 'Report',
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
          body: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: IndexedStack(index: selectedIndex, children: pages),
          ),
        );
      },
    );
  }
}

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
