import 'package:carpark/screens/incident/add_incident_report.dart';
import 'package:carpark/utils/colors.dart';
import 'package:flutter/material.dart';

class IncidentReport extends StatefulWidget {
  const IncidentReport({super.key});

  @override
  State<IncidentReport> createState() => _IncidentReportState();
}

class _IncidentReportState extends State<IncidentReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => AddIncidentReport()));
        },
        child: Icon(Icons.add),
        backgroundColor: mainBtnColor,
      ),
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
