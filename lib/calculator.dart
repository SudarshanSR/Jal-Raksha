import 'package:flutter/material.dart';

var acceptable = const {
  "Cr": 0.05,
  "Cd": 0.003,
  "Pb": 0.01,
  "As": 0.01,
  "Hg": 0.001,
};

var permissible = const {
  "Cr": 0.05,
  "Cd": 0.003,
  "Pb": 0.01,
  "As": 0.05,
  "Hg": 0.001,
};

// TODO -> Fix formula by adding weights
double hpi(Map<String, double> concentrations) {
  double result = 0.0;

  concentrations.forEach(
    (metal, conc) => result +=
        (conc - acceptable[metal]!) /
        (permissible[metal]! - acceptable[metal]!),
  );

  return result * 100;
}

double ci(Map<String, double> concentrations) {
  double result = 0.0;

  concentrations.forEach(
    (metal, conc) => result += conc / acceptable[metal]! - 1,
  );

  return result;
}

double hei(Map<String, double> concentrations) {
  double result = 0.0;

  concentrations.forEach((metal, conc) => result += conc / acceptable[metal]!);

  return result;
}

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Map<String, double> concentrations = {
    "Cr": double.negativeInfinity,
    "Cd": double.negativeInfinity,
    "Pb": double.negativeInfinity,
    "As": double.negativeInfinity,
    "Hg": double.negativeInfinity,
  };

  late final Map entries = {
    "Cr": HMEntry(
      text: "Chromium (Cr)",
      onValueChanged: (double? value) =>
          concentrations["Cr"] = value ?? double.negativeInfinity,
    ),
    "Cd": HMEntry(
      text: "Cadmium (Cd)",
      onValueChanged: (double? value) =>
          concentrations["Cd"] = value ?? double.negativeInfinity,
    ),
    "Pb": HMEntry(
      text: "Lead (Pb)",
      onValueChanged: (double? value) =>
          concentrations["Pb"] = value ?? double.negativeInfinity,
    ),
    "As": HMEntry(
      text: "Arsenic (As)",
      onValueChanged: (double? value) =>
          concentrations["As"] = value ?? double.negativeInfinity,
    ),
    "Hg": HMEntry(
      text: "Mercury (Hg)",
      onValueChanged: (double? value) =>
          concentrations["Hg"] = value ?? double.negativeInfinity,
    ),
  };

  final List indices = ["HPI", "CI", "HEI"];

  late Map<String, double?> results = {for (String text in indices) text: null};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView(children: entries.values.cast<Widget>().toList()),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  results["HPI"] = hpi(concentrations);
                  results["CI"] = ci(concentrations);
                  results["HEI"] = hei(concentrations);
                });
              },
              child: Text("Calculate"),
            ),
            Card(
              child: Column(
                children: [
                  for (String text in indices)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "$text: ${results[text] != null ? results[text]!.toStringAsFixed(2) : ""}",
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HMEntry extends StatefulWidget {
  final String text;
  final myController = TextEditingController();

  final void Function(double? value) onValueChanged;

  HMEntry({super.key, required this.text, required this.onValueChanged});

  double get() {
    return double.parse(myController.text);
  }

  @override
  State<HMEntry> createState() => _HMEntryState();
}

class _HMEntryState extends State<HMEntry> {
  var prev = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text),
          ),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: widget.myController,
            decoration: InputDecoration(suffixText: "mg/L"),
            onChanged: (text) => widget.onValueChanged(double.tryParse(text)),
          ),
        ),
      ],
    );
  }
}
