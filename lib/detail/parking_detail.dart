
import 'package:carpark/utils/colors.dart';
import 'package:carpark/utils/message_utils.dart';
import 'package:carpark/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ParkingDetail extends StatefulWidget {
  String name;
  var price;
  var flag;
   ParkingDetail({super.key,required this.name,required this.price,required this.flag});

  @override
  State<ParkingDetail> createState() => _ParkingDetailState();
}

class _ParkingDetailState extends State<ParkingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset("asseets/logo.png",height: 300,)),
            Row(
              children: [
                Text("Parking Space Name: ",style: TextStyle(color: black,fontSize: 22,fontWeight: FontWeight.bold),
                ),Text(widget.name,style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w600),)],
            ),
            Row(
              children: [
                Text("Price Per Hr: ",style: TextStyle(color: black,fontSize: 22,fontWeight: FontWeight.bold),
                ),Text(widget.price.toString(),style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w600),)],
            ),
            SaveButton(title: "Book", onTap: (){
              showMessageBar("Booking Complete", context);
              Navigator.pop(context);
            }, color: mainBtnColor)
          ],
        ),
      ),
    );
  }
}
