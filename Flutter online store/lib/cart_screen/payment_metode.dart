import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/Cart_controller.dart';
import 'package:emart_app/views/home_screen/Home.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class paymentMethods extends StatelessWidget {
  paymentMethods({super.key});
  var paymentMethodesImg = [imgPaypal, imgStripe, imgCod];
  var paymentMethode = ['paypal', 'Stripe', 'Cach on delivery'];
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        // ignore: prefer_const_constructors
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Choose Payment Method',
            style: TextStyle(color: darkFontGrey, fontFamily: semibold),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingOreder.value
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor)),
                  )
                : ourbutton(
                    color: redColor,
                    title: 'Place my order',
                    onpressed: () async {
                      await controller.placeMyorder(
                          orderPaymentMethod:
                              paymentMethode[controller.paymentIndex.value],
                          totalAmount: controller.totaIp.value);
                      await controller.cleareCart();
                      Get.snackbar('', 'Order placed successfully');
                      Get.off(Home());
                    })),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodesImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changepaymentindex(index);
                },
                child: Container(
                  // we add it to apply change in borderRadius
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 4,
                      )),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodesImg[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        // TO ADD COLOR FOR IMAGE
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,

                        /// color you want
                        color: controller.paymentIndex.value == index
                            ? Colors.red.withOpacity(.4)
                            : Colors.transparent,
                      ), // we add it to controller of raduis of checkbox
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          '${paymentMethode[index]}',
                          style: TextStyle(
                              color: whiteColor,
                              fontFamily: semibold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
