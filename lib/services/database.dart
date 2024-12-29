class Database {
  //Add Ads
  // Future<String> addAds(
  //     {required String postName,
  //     required String postDescription,
  //     required String category,
  //       required String authorName,
  //     required Uint8List file}) async {
  //   String res = 'Wrong medicineName or uuidword';
  //   try {
  //     if (postName.isNotEmpty || category.isNotEmpty) {
  //       String photoURL = await StorageMethods().uploadImageToStorage(
  //         'ProfilePics',
  //         file,
  //       );

  //       var uuid = Uuid().v4();
  //       //Add User to the database with modal
  //       AddsModel userModel = AddsModel(
  //           authorName:authorName,
  //           addDescription: postDescription,
  //           category: category,
  //           AdName: postName,
  //           uid: FirebaseAuth.instance.currentUser!.uid,
  //           uuid: uuid,
  //           photoURL: photoURL);
  //       await FirebaseFirestore.instance
  //           .collection('ads')
  //           .doc(uuid)
  //           .set(userModel.toJson());
  //       res = 'success';
  //     }
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }
}
