// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/widgets/custom_textfiled.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

List colors = [
  4294198070,
  4283215696,
  4280391411,
  4278190080,
  4294967040,
];
var catrgorisimage = [
  imgFc1,
  imgFc2,
  imgFc3,
  imgFc4,
  imgFc5,
  imgFc6,
  imgFc7,
  imgFc8,
  imgFc9,
];
var catrgorislist = [
  'Women Dress',
  'Men Clothing & Fashion',
  'Computer & Accessories',
  'Automobile',
  'Kids & Toys',
  'Sport',
  'Jewelery',
  'Cellphone & Tab',
  'Furniture',
];
String _drobDownValue = 'Women Dress';
Color? _color;

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

final _random = Random();

class _AddProductState extends State<AddProduct> {
  @override
  var desccontrolelr = TextEditingController();
  var namecontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var quntitycontroller = TextEditingController();
  var ratingcontroller = TextEditingController();
  var sellercontroller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var imageLink;
  Widget build(BuildContext context) {
    print(Colors.red.value);
    print(Colors.green.value);
    print(Colors.blue.value);
    print(Colors.black.value);
    print(Colors.yellowAccent.value);
    var controller = Get.put(ProductController());
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.9, 0.9],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'Add products',
            style: TextStyle(color: Colors.white),
          ),
          leading: BackButton(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'category name',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          focusColor: redColor,
                          decoration: InputDecoration(
                            fillColor: lightGrey,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: redColor)),
                          ),
                          elevation: 10,
                          isExpanded: true,
                          menuMaxHeight: 200,
                          items: catrgorislist.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _drobDownValue,
                          onChanged: (selectedValue) {
                            setState(() {
                              _drobDownValue = selectedValue!;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'color',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          color: lightGrey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                colors.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(colors[index])),
                                        height: 50,
                                        width: 50,
                                      ),
                                    )),
                          ),
                        ),
                        custom_textfield(
                          validator: (value) {
                            if (value!.length > 200) {
                              return 'describtion cant to be larger than 200 letter';
                            }
                            if (value.length <= 0) {
                              return 'describtion cant to be less than 0 letter';
                            }
                            return null;
                          },
                          name_filed: 'describtion',
                          hinttext: 'product describtion',
                          controller: desccontrolelr,
                        ),
                        Text(
                          'image',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: bold,
                          ),
                        ),
                        ourbutton(
                            color: redColor,
                            title: 'Choose Image',
                            onpressed: () {
                              Get.bottomSheet(
                                  Container(
                                      decoration: BoxDecoration(
                                        color: lightGrey.withOpacity(.8),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                      height: 170,
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker();
                                              final XFile? image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (image != null) {
                                                Reference ref = FirebaseStorage
                                                    .instance
                                                    .ref(
                                                        'product/${currerntuser!.uid}/${image.name}');
                                                await ref
                                                    .putFile(File(image.path));
                                                imageLink =
                                                    await ref.getDownloadURL();
                                              }
                                            },
                                            leading: Icon(
                                              CupertinoIcons.photo_fill,
                                              color: redColor,
                                              size: 30,
                                            ),
                                            title: Text(
                                              'form golore',
                                              style: TextStyle(
                                                  color: darkFontGrey,
                                                  fontFamily: semibold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () async {
                                              final ImagePicker _piker =
                                                  ImagePicker();
                                              final XFile? image =
                                                  await _piker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (image != null) {
                                                var ref = FirebaseStorage
                                                    .instance
                                                    .ref(
                                                        'product/${currerntuser!.uid}/${image.name}');
                                                await ref
                                                    .putFile(File(image.path));
                                                imageLink =
                                                    await ref.getDownloadURL();
                                              }
                                            },
                                            title: Text(
                                              'form Camera',
                                              style: TextStyle(
                                                  color: darkFontGrey,
                                                  fontFamily: semibold,
                                                  fontSize: 20),
                                            ),
                                            leading: Icon(
                                              color: redColor,
                                              CupertinoIcons.photo_camera,
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      )),
                                  elevation: 1);
                            }),
                        custom_textfield(
                          validator: (value) {
                            if (value!.length > 100) {
                              return 'name cant to be larger than 100 letter';
                            }
                            if (value.length < 2) {
                              return 'name cant to be less than 2 letter';
                            }
                            return null;
                          },
                          name_filed: 'name',
                          hinttext: 'Name of product ',
                          controller: namecontroller,
                        ),
                        custom_textfield(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.length > 5) {
                              return 'price cant to be larger than 5 letter';
                            }
                            if (value.length <= 0) {
                              return 'price cant to be less than 0 letter';
                            }
                            return null;
                          },
                          name_filed: 'price',
                          hinttext: 'price of product',
                          controller: pricecontroller,
                        ),
                        custom_textfield(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.length > 10000) {
                              return 'quntity cant to be larger than 10000 letter';
                            }
                            if (value.length <= 0) {
                              return 'price cant to be less than 0 letter';
                            }
                            return null;
                          },
                          name_filed: 'quntity',
                          hinttext: 'Quntity of product',
                          controller: quntitycontroller,
                        ),
                        custom_textfield(
                          validator: (value) {
                            if (int.parse(value) >= 5) {
                              return 'rating cant to be larger than 5 letter';
                            }
                            if (value.length <= 0) {
                              return 'rating cant to be less than 0 letter';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          name_filed: 'rating',
                          hinttext: 'Rating',
                          controller: ratingcontroller,
                        ),
                        custom_textfield(
                          validator: (value) {
                            if (value!.length > 100) {
                              return 'seller name cant to be larger than 100 letter';
                            }
                            if (value.length <= 0) {
                              return 'seller name cant to be less than 0 letter';
                            }
                            return null;
                          },
                          name_filed: 'seller',
                          hinttext: 'sellername ',
                          controller: sellercontroller,
                        ),
                      ],
                    )),
                ourbutton(
                    color: redColor,
                    title: 'Add product',
                    onpressed: () {
                      if (_formkey.currentState!.validate() &&
                          imageLink != null) {
                        controller.addProduct(
                          qty: quntitycontroller.text,
                          categoryName: _drobDownValue,
                          color: colors,
                          desc: desccontrolelr.text,
                          imag: ['$imageLink'],
                          prdName: namecontroller.text,
                          price: pricecontroller.text,
                          rating: ratingcontroller.text,
                          seller: sellercontroller.text,
                          subcactegory: 'Wedding & Event',
                          whislist: [''],
                          vendor_id: 'MZyggs7q0OVyauXSioGKP1l882i2',
                        );
                        print(currerntuser!.uid);
                        Get.snackbar('success', ' Add product successful');
                      } else {
                        print(currerntuser!.uid);
                        Get.snackbar('Faild', 'must chosse image');
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
