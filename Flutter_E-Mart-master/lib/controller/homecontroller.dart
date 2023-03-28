import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  var username = '';
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  getUsername() async {
    var n = await firestore
        .collection(usercollection)
        .where('id', isEqualTo: currerntuser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
    print(username);
  }
}
