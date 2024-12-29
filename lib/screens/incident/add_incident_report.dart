import 'dart:typed_data';

import 'package:carpark/screens/pages/main_dashboard.dart';
import 'package:carpark/services/storage_,methods.dart';
import 'package:carpark/utils/colors.dart';
import 'package:carpark/utils/image_utils.dart';
import 'package:carpark/utils/message_utils.dart';
import 'package:carpark/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddIncidentReport extends StatefulWidget {
  const AddIncidentReport({super.key});

  @override
  State<AddIncidentReport> createState() => _AddIncidentReportState();
}

class _AddIncidentReportState extends State<AddIncidentReport> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _postDescController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  bool _isLoading = false;

  var uuid = Uuid().v4();

  // List of items in our dropdown menu

  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Report Incident",
          style: TextStyle(color: black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text(""));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No data available'));
                }
                var snap = snapshot.data;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => selectImage(),
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 59,
                                  backgroundImage: MemoryImage(_image!))
                              : GestureDetector(
                                  onTap: () => selectImage(),
                                  child: Image.asset('assets/post.png'),
                                ),
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Title",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: _nameController,
                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: borderColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            hintText: "Title",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                color: Colors.black, fontSize: 12)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: _typeController,
                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: borderColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            hintText: "Incident Type",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                color: Colors.black, fontSize: 12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Location",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(

                        controller: _postDescController,
                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: borderColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            hintText: "Enter Location",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                color: Colors.black, fontSize: 12)),
                      ),
                    ),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SaveButton(
                                title: "Report",
                                onTap: () async {
                                  if (_nameController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Title Name is Required")));
                                  } else if (_postDescController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Location is Required")));
                                  } else if (_image == null) {
                                    showMessageBar(
                                        "Image is Required", context);
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    String photoURL = await StorageMethods()
                                        .uploadImageToStorage(
                                      'ProfilePics',
                                      _image!,
                                    );
                                    await FirebaseFirestore.instance
                                        .collection("incident")
                                        .doc(uuid)
                                        .set({
                                      "title": _nameController.text,
                                      "description": _postDescController.text,
                                      "image": photoURL,

                                      "category": _typeController.text,
                                    });
                                    // await Database().addAds(
                                    //     postDescription:
                                    //         _postDescController.text,
                                    //     postName: _nameController.text,
                                    //     category: dropdownvalue,
                                    //     file: _image!,
                                    //     authorName: snap['fullName']);

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showMessageBar(
                                        "Incident Report Successfully",
                                        context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                MainDashboard()));
                                  }
                                },
                                color: mainBtnColor),
                          )
                  ],
                );
              }),
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
