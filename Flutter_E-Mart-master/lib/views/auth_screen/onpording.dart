// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors

import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/Account_screen/addProduct.dart';
import 'package:emart_app/widgets/cliperimage.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late PageController _pageController;
  int pageindex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            pageindex = value;
                          });
                        },
                        itemCount: data.length,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          return onbordring(
                            description: data[index].description,
                            image: data[index].image,
                            title: data[index].title,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          ...List.generate(
                              data.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Dotindecator(
                                      isActive: index == pageindex,
                                    ),
                                  )),
                          Spacer(),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (pageindex == data.length - 1) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => login_screen(),
                                      ));
                                    }
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_right_alt_sharp,
                                  size: 30,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}

class Dotindecator extends StatelessWidget {
  final bool isActive;
  const Dotindecator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 12 : 4,
      height: 4,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}

class onbordring extends StatelessWidget {
  final String image, title, description;
  const onbordring({
    Key? key,
    required this.description,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipPath(
          clipper: ImageClipper(),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(120),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20)),
            child: Image.asset(
              image,
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
      ],
    );
  }
}

class onporder {
  final String image, title, description;

  onporder(this.image, this.title, this.description);
}

final List<onbordring> data = [
  onbordring(
    description:
        'Publish up your selfies to make yourself\nmore beautiful with this app.',
    image: 'assets/images/1.jpg',
    title: '20% Discount \nNew Arrival Product',
  ),
  onbordring(
    description:
        'Publish up your selfies to make yourselfmore beautiful with this app.',
    image: 'assets/images/2.jpg',
    title: 'Take Advantage\nOf The Offer Shopping ',
  ),
  onbordring(
    description: 'All Types Offers\nWithin Your Reach',
    image: 'assets/images/3.jpg',
    title: '20% Discount \nNew Arrival Product',
  ),
];
