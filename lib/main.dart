import 'package:flutter/material.dart';
import 'package:jal_raksha/calculator.dart';
import 'package:provider/provider.dart';
import 'package:material_charts/material_charts.dart';

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
    InsertPage(),
    MapPage(),
    ExportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.water_drop),
            title: Text("Jal Raksha"),
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
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.calculate),
                label: 'HMPI Calc',
              ),
              NavigationDestination(icon: Icon(Icons.add), label: 'Add Data'),
              NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
              NavigationDestination(icon: Icon(Icons.upload), label: 'Export'),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: IndexedStack(index: selectedIndex, children: pages),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Placeholder()),
          // Expanded(
          //   child: Row(
          //     children: [
          //       Expanded(child: Placeholder()),
          //       Expanded(child: Placeholder()),
          //       Expanded(child: Placeholder()),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Placeholder()),
                Expanded(
                  child: MaterialPieChart(
                    data: [
                      PieChartData(value: 62.5, label: 'High'),
                      PieChartData(value: 25, label: 'Medium'),
                      PieChartData(value: 12.5, label: 'Low'),
                    ],
                    width: double.maxFinite,
                    height: double.maxFinite,
                    style: PieChartStyle(showLegend: true),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InsertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class ExportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
