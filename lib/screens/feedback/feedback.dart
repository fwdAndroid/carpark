import 'dart:math';

import 'package:carpark/screens/pages/main_dashboard.dart';
import 'package:carpark/utils/colors.dart';
import 'package:carpark/utils/message_utils.dart';
import 'package:carpark/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController descriptionController = TextEditingController();
  double rating = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    borderSide: BorderSide(
                      color: textColor,
                    )),
                contentPadding: EdgeInsets.all(8),
                fillColor: Color(0xffF6F7F9),
                hintText: "Descripción",
                hintStyle: GoogleFonts.nunitoSans(fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          SaveButton(
            color: mainBtnColor,
            title: "Submit",
            onTap: () async {
              try {
                // Reference to the specific service document
                showMessageBar("Rate Successfully Submitted", context);
                // Navigate to the main dashboard or show a success message
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => MainDashboard()));
              } catch (e) {
                print("Error updating rating: $e");
              }
            },
          ),
        ],
      ),
    );
  }
}
