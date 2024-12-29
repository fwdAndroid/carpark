import 'package:carpark/screens/feedback/feedback.dart';
import 'package:carpark/screens/incident/incident_report.dart';
import 'package:carpark/utils/colors.dart';
import 'package:carpark/widgets/logout_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No data available'));
                }
                var snap = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          snap['firstName'],
                          style: TextStyle(
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                        Text(
                          snap['email'],
                          style: TextStyle(
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.language),
            title: Text("Language Settings"),
          ),
          Divider(
            color: black,
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          Divider(
            color: black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => FeedbackScreen()));
            },
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.feedback),
            title: Text("FeebBack"),
          ),
          Divider(
            color: black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => IncidentReport()));
            },
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.report_problem),
            title: Text("Incident Report"),
          ),
          Divider(
            color: black,
          ),
          ListTile(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return LogoutWidget();
                },
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          )
        ],
      ),
    ));
  }
}
