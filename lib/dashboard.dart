import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var totalLocations = 0;
  var safeSources = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.pin_drop_outlined)),
                          TextSpan(
                            text: "$totalLocations",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "\nTotal Locations"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.health_and_safety_outlined),
                          ),
                          TextSpan(
                            text: "$safeSources",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "\nSafe Sources"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
            ),
          ),
          RecentDataWidget(),
        ],
      ),
    );
  }
}

class RecentDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "Recent Research",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    RecentCard(
                      name: "Mumbai, Maharashtra",
                      latitude: 19.076,
                      longitude: 72.877,
                      score: 85.2,
                      date: DateTime(2024, 1, 15),
                    ),
                    RecentCard(
                      name: "Delhi, NCR",
                      latitude: 28.704,
                      longitude: 77.102,
                      score: 62.8,
                      date: DateTime(2024, 1, 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentCard extends StatefulWidget {
  final String name;
  final double latitude;
  final double longitude;
  final double score;
  final DateTime date;

  const RecentCard({
    super.key,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.score,
    required this.date,
  });

  @override
  State<RecentCard> createState() => _RecentCardState();
}

class _RecentCardState extends State<RecentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: "\n${widget.latitude}° ${widget.longitude}°"),
              TextSpan(
                text: "\nScore: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: "${widget.score}"),
              TextSpan(
                text: "\nDate & Time: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: widget.date.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
