import 'package:carpark/screens/incident/add_incident_report.dart';
import 'package:carpark/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("incident").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No Incident Reported Yet",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  final Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: ListTile(
                        title: Text(data['title']),
                        subtitle: Text(data['description']),
                      )),
                    ),
                  );
                });
          }),
    );
  }
}
