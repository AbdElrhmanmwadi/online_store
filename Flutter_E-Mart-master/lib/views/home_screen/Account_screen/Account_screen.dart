// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/Auth_Medle.dart';
import 'package:emart_app/controller/Auth_controller.dart';
import 'package:emart_app/controller/savelogincontrolle.dart';
import 'package:emart_app/views/chat/message_scrren.dart';
import 'package:emart_app/views/home_screen/Account_screen/addProduct.dart';
import 'package:emart_app/views/home_screen/Account_screen/edit_Account_screen.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/auth_screen/methodlogin.dart';
import 'package:emart_app/views/order_screen/order_scree.dart';
import 'package:emart_app/views/splach_screen/Splash_screen.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:emart_app/views/wishlist_screen.dart/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';

class Account_screen extends StatelessWidget {
  Account_screen({super.key});

  setdata() async {
    CollectionReference userreff =
        FirebaseFirestore.instance.collection('users');
    // first  way  to add user
    // userreff.add({
    //   'username': 'Abood',
    //   'password': "123123",
    //   'imageurl': '12',
    //   'Email': '123@gmail.com',
    // });

    // socand way to add user

    userreff.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'username': 'Abood',
      'password': "1231234",
      'imageurl': '12',
      'Email': '123@gmail.com',
    });
  }

  getdata() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      return value.docs.forEach((element) {
        print(element.data()['username']);
      });
    });
  }

// real time
  realtimeget() async {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.data()['username']);
      });
    });
  }

// using updata or set
// updata updata the data you need only and if doc is not exist he will not  add it
// set dealet all data only you want is keep and if doc is not exist he will add it
  Updata() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection('users');
    userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'username': 'hassan',
      'password': "1111111",
      'imageurl': '22',
    }).then((value) {
      print('Update is success');
    }).catchError((e) {
      print('Error : $e');
    });
  }

  delete() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection('users');
    userref.doc(FirebaseAuth.instance.currentUser!.uid).delete().then((value) {
      print('deleate is success');
    }).catchError((e) {
      print('Error : $e');
    });
  }

  // transaction all operation will done or not
  // operration read then write
  var userdoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  trans() async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      // start
      var docsnap = await transaction.get(userdoc);
      if (docsnap.exists) {
        // write
        transaction.update(userdoc, {'username': 'Abood'});
      } else {
        print('USer is not exists');
      }

      // end
    });
  }

  // Batch write make it able to make operation in multple documant
  var userdoc1 = FirebaseFirestore.instance
      .collection('users')
      .doc('YozUwHbAKNgc30yLEWDPMgbHIsx2');
  var userdoc2 = FirebaseFirestore.instance
      .collection('users')
      .doc('doeaibZlpZTTOzk7e8Jwg3KHib92');

  batchWrite() async {
    var batch = FirebaseFirestore.instance.batch();
    batch.delete(userdoc1);
    batch.update(userdoc2, {'username': "mohammed"});
    batch.commit();
  }

  // get data and stor in list to disply
  // we can use list view bilder to show data
  List userdata = [];
  var datauser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  getdataofuser() async {
    var respnsebody = await datauser.get();
    // setState(() {
    //   userdata.add(respnsebody.data());
    //   print('${userdata[0]['name']}');
    // });
  }

  // @override
  // void initState() {
  //   getdataofuser();
  //   // setdata();
  //   // trans();
  //   // getdata();
  //   // realtimeget();
  //   // Updata();
  //   // delete();
  //   // batchWrite();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var radius = 30.0;
    ProfileContoller controller = Get.put(ProfileContoller());
    Auth_controller controllerAuth = Get.put(Auth_controller());
    fierStorServices.getcount();
    var profileButtonslist = [
      'my orders',
      'my wish list',
      'my messagse',
      'add product',
    ];
    var profileButtonsIcons = [icOrders, icOrders, icMessages, icAdd];

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
          body: StreamBuilder(
              // it is get static method
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return AlertDialog(
                    content: Text('Error in data'),
                  );
                }
                var data = snapshot.data;
                return SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 22,
                            ),
                            color: whiteColor,
                            onPressed: () {
                              controller.nameController.text = data['name'];
                              // controller:
                              // controller.passwordController.text =
                              //     data['password'];
                              Get.to(() => edit_Account(
                                    data: data,
                                  ));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            // for spacing buttwen two row
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // first row
                              Row(
                                children: [
                                  SizedBox(
                                    child: GestureDetector(
                                      onLongPress: () {
                                        Get.dialog(
                                          Container(
                                            child: Center(
                                              child: Hero(
                                                tag: 'imagehero',
                                                child: CircleAvatar(
                                                  backgroundColor: whiteColor,
                                                  backgroundImage:
                                                      data['imageUrl'] == ''
                                                          ? AssetImage(
                                                              'assets/images/imageprofile.jpg',
                                                            )
                                                          : NetworkImage(
                                                              '${snapshot.data['imageUrl'].toString()}',
                                                            ) as ImageProvider,
                                                  radius: 150,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          Get.back();
                                        });
                                      },
                                      child: Hero(
                                        tag: 'imagehero',
                                        child: CircleAvatar(
                                          backgroundColor: whiteColor,
                                          backgroundImage:
                                              data['imageUrl'] == ''
                                                  ? AssetImage(
                                                      'assets/images/imageprofile.jpg',
                                                    )
                                                  : NetworkImage(
                                                      '${snapshot.data['imageUrl'].toString()}',
                                                    ) as ImageProvider,
                                          radius: radius,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data['name']}',

                                        // '00',
                                        style: TextStyle(color: lightGrey),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${snapshot.data['email']}', // '00',

                                        style: TextStyle(color: lightGrey),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // two row
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      SaveController().deleatestorge();
                                      await controllerAuth.singout();
                                      Get.off(() => login_screen());
                                    },
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(color: whiteColor),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: whiteColor)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                          future: fierStorServices.getcount(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(redColor)),
                              );
                            } else {
                              print(snapshot.data);
                              var countData = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCard(
                                    title: 'in your cart',

                                    // count: '00',
                                    count: '${countData[0]}',
                                    width_div: 3.2,
                                  ),
                                  detailsCard(
                                    title: 'in your Wishlist',
                                    count: '${countData[1]}',
                                    // count: '00',
                                    width_div: 3.2,
                                  ),
                                  detailsCard(
                                    title: 'in your orders',
                                    count: '${countData[2]}',
                                    // count: '00',
                                    width_div: 3.2,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     detailsCard(
                        //       title: 'in your cart',

                        //       // count: '00',
                        //       count: '${data['cart_count']}',
                        //       width_div: 3.2,
                        //     ),
                        //     detailsCard(
                        //       title: 'in your Wishlist',
                        //       count: '${data['whishlist_count']}',
                        //       // count: '00',
                        //       width_div: 3.2,
                        //     ),
                        //     detailsCard(
                        //       title: 'in your orders',
                        //       count: '${data['order_count']}',
                        //       // count: '00',
                        //       width_div: 3.2,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => OrerersScreen());
                                          break;
                                        case 1:
                                          Get.to(() => WishlistScreen());
                                          break;
                                        case 2:
                                          Get.to(() => messageScreen());
                                          break;
                                        case 3:
                                          Get.to(() => AddProduct());
                                      }
                                    },
                                    leading: Image.asset(
                                      profileButtonsIcons[index],
                                      width: 22,
                                    ),
                                    title: Text(
                                      profileButtonslist[index],
                                      style: TextStyle(
                                          fontFamily: semibold,
                                          color: darkFontGrey),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profileButtonsIcons.length),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}

class detailsCard extends StatelessWidget {
  final width_div, count, title;
  const detailsCard(
      {Key? key,
      required this.count,
      required this.title,
      required this.width_div})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width / width_div,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style:
                TextStyle(color: darkFontGrey, fontFamily: bold, fontSize: 16),
          ),
          Text(
            title,
            style: TextStyle(
              color: darkFontGrey,
            ),
          ),
        ],
      ),
    );
  }
}
