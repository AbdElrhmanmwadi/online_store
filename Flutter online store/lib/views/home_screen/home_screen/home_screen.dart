// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/changethem.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:emart_app/views/home_screen/catogers_scrren/ItemDetalis.dart';
import 'package:emart_app/views/home_screen/home_screen/compounant/featuaer_button.dart';
import 'package:emart_app/views/home_screen/home_screen/compounant/home_Button.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var sliderlist = [
  imgSlider1,
  imgSlider2,
  imgSlider3,
  imgSlider4,
];
var sliderlist_Two = [
  imgSs1,
  imgSs2,
  imgSs3,
  imgSs4,
];
var featuredimages1 = [
  imgS1,
  imgS2,
  imgS3,
];
var featuredimages2 = [imgS4, imgS5, imgS6];
var featuredTitles1 = ['women Dress', 'girls Dress', 'grils Watches'];
var featuredTitles2 = ['boys Glasses', 'mobile Phone', 'T sharts '];

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: lightGrey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            color: lightGrey,
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                filled: true,
                border: InputBorder.none,
                fillColor: whiteColor,
                hintText: 'Secarh...',
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          // swiper image for 0 to final and loop
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 140,
                      itemCount: sliderlist.length,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color:
                                      Color.fromARGB(255, 141, 138, 138), //New
                                  blurRadius: 50.0,
                                  offset: Offset(100, 100))
                            ], borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              sliderlist[index],
                              fit: BoxFit.fill,
                            ),
                          )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => home_Button(
                          image: index == 0 ? icTodaysDeal : icFlashDeal,
                          title_image:
                              index == 0 ? "Todays Deal" : 'Flash Sale',
                          width_image: 26.0,
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),

                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 140,
                      itemCount: sliderlist_Two.length,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),

                            // to make border corner

                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color:
                                      Color.fromARGB(255, 141, 138, 138), //New
                                  blurRadius: 50.0,
                                  offset: Offset(100, 100))
                            ], borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              sliderlist_Two[index],
                              fit: BoxFit.fill,
                            ),
                          )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: List.generate(
                        3,
                        (index) => home_Button(
                              width_contaner: 3.5,
                              height_contaner: .12,
                              image: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title_image: index == 0
                                  ? "top Catgories"
                                  : index == 1
                                      ? 'Brand'
                                      : 'Top Sellers',
                              width_image: 26.0,
                            )),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'featured Categories',
                      style: TextStyle(fontFamily: semibold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(),
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                featuredButton(
                                    title: featuredTitles1[index],
                                    icon: featuredimages1[index]),
                                SizedBox(
                                  height: 10,
                                ),
                                featuredButton(
                                  title: featuredTitles2[index],
                                  icon: featuredimages2[index],
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Featured Products

                  Container(
                    decoration: BoxDecoration(color: lightGrey),
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Featured Products',
                          style: TextStyle(fontFamily: semibold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              6,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 141, 138, 138), //New
                                            blurRadius: 5.0,
                                            offset: Offset(5, 5))
                                      ],
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'laptop 4GB/64GB',
                                        style: TextStyle(
                                            color: darkFontGrey,
                                            fontFamily: semibold),
                                      ),
                                      Text(
                                        '\$600.000',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: redColor,
                                            fontFamily: bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // swaper
                  VxSwiper.builder(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 140,
                      itemCount: sliderlist.length,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color:
                                      Color.fromARGB(255, 141, 138, 138), //New
                                  blurRadius: 50.0,
                                  offset: Offset(100, 100))
                            ], borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              sliderlist_Two[index],
                              fit: BoxFit.cover,
                            ),
                          )),

                  // all prodducts scetion
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Text(
                      'All products',
                      style: TextStyle(
                          fontFamily: bold, color: darkFontGrey, fontSize: 18),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                      stream: fierStorServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else {
                          var allproduct = snapshot.data!.docs;
                          return Container(
                            decoration: BoxDecoration(),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproduct.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing:
                                    8, // space bettwen to and bottom
                                crossAxisSpacing:
                                    8, // space bettwen left and rghit
                                mainAxisExtent: 300, //  height of one contaner

                                crossAxisCount: 2, // numper of column
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ItemDetails(
                                        data: allproduct[index],
                                        title:
                                            '${allproduct[index]['p_name']}'));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 141, 138, 138), //New
                                              blurRadius: 5.0,
                                              offset: Offset(5, 5))
                                        ],
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          allproduct[index]['p_imgs'][0],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        Spacer(),
                                        Text(
                                          '${allproduct[index]['p_name']}',
                                          style: TextStyle(
                                              color: darkFontGrey,
                                              fontFamily: semibold),
                                        ),
                                        Text(
                                          '${allproduct[index]['p_price']}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: redColor,
                                              fontFamily: bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        ;
                      }),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
