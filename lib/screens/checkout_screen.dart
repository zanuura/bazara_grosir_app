import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/payment_screen.dart';
import 'package:product_groceries/widgets/custom_text.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int idSelected = 1;
  int productPrice = 0;
  int adminCost = 0;
  int shippingCost = 0;
  int totalPrice = 0;
  String paymentSelected = '';
  bool itsReady = false;
  List<int> orderId = [];

  @override
  void initState() {
    super.initState();
    getPaymentInfo(0);
  }

  getPaymentInfo(int costAdmin) {
    setState(() {
      checkoutList.forEach((item) {
        productPrice += int.parse(item['harga'].toString());
        // adminCost = costAdmin;
        shippingCost += int.parse(item['biaya pengiriman'].toString());
        totalPrice = productPrice + adminCost + shippingCost;
        // orderId.addAll([item['id']]);
      });
      // log(orderId.toString());
      log(totalPrice.toString());
    });
  }

  getAdminCostInfo(int costAdmin) {
    setState(() {
      adminCost = costAdmin;
      totalPrice = adminCost + productPrice + shippingCost;
    });
  }

  chekoutPay() {
    for (int i = 0; i < checkoutList.length; i++) {
      orderList.add({
        'id': orderList.length + 1,
        'produk': checkoutList[i]['produk'],
        'image': checkoutList[i]['image'],
        'qty': checkoutList[i]['qty'],
        'total': checkoutList[i]['subtotal'],
        'status': 'Menunggu Pembayaran',
        'invoice': 'igbiuiu87688hjbjh',
        'pengiriman': checkoutList[i]['pengiriman'],
        'alamat':
            'Konohagakure Jl.GreenLine No.112 Rt/Rw 009/002, Kel.Atlantis, Kec.Pacific atas',
        'pembayaran': paymentSelected,
        'biaya admin': adminCost,
        'biaya pengiriman': shippingCost,
      });
      orderId.add(orderList.length + 1);
      log(orderList.length.toString());
      log(orderList.toString());
      log(orderId.toString());
      // orderList.addAll(
      //   checkoutList
      // );
    }
    setState(() {
      checkoutList.clear();
      cartList.clear();
      cartProduct.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Warna.blueBaz),
        title: Text(
          'Pilih Pembayaran',
          style: TextStyle(
            color: Warna.blueBaz,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          paymentMethodBody(),
          Divider(
            thickness: 8,
            color: Colors.grey.shade200,
          ),
          paymentSummary(),
          Divider(
            thickness: 8,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.shield_outlined,
              size: 50,
              color: Warna.goldHalfBaz,
            ),
            title: Text('Pembayaran Terjamin'),
            subtitle: Text(
                'Bazara Selalu Menjamin keamanan dana yang kamu bayarkan di tiap transaksi'),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total Harga'),
                Text(
                  currText(text: totalPrice.toString()),
                  style: TextStyle(
                      color: Warna.blueBaz,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              child: ElevatedButton(
                  onPressed: itsReady == true
                      ? () {
                          chekoutPay();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PaymentScreen(
                                orderId: orderId,
                              );
                            },
                          ));
                        }
                      : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: itsReady == true
                        ? Warna.goldHalfBaz
                        : Colors.grey.shade200,
                    // disabledBackgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Bayar',
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget paymentSummary() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Ringkasan Pembayaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Harga Produk',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                currText(
                  text: productPrice.toString(),
                ),
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Admin',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                currText(
                  text: adminCost.toString(),
                ),
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pengiriman',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                currText(
                  text: shippingCost.toString(),
                ),
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.shade200,
          indent: 15,
          endIndent: 15,
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Harga',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                currText(
                  text: totalPrice.toString(),
                ),
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget paymentMethodBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        ListView.builder(
          itemCount: paymentMethodList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (context, index) {
            final items = paymentMethodList[index];
            return paymentItemCard(
              id: items['id'],
              name: items['name'],
              image: items['image'],
              cost: items['cost'].toString(),
              isSelected: items['selected'],
              selected: items['selected method'],
              onTap: () {
                if (items['selected'] == false && items['id'] != idSelected) {
                  setState(() {
                    items['selected'] = true;
                    idSelected = items['id'];
                  });
                  if (idSelected == 2) {
                    methodMenuListItems(indexselected: index);
                    paymentMethodList[index]['selected method'] = '';
                    paymentSelected = '';
                    setState(() {});
                    // getPaymentInfo(4000);
                  } else if (idSelected == 3) {
                    methodMenuListItems(indexselected: index);
                    paymentMethodList[index]['selected method'] = '';
                    paymentSelected = '';
                    setState(() {});
                    // getPaymentInfo(2000);
                  } else if (idSelected == 1) {
                    getAdminCostInfo(0);
                    paymentMethodList[index]['selected method'] = '';
                    setState(() {});
                  }
                } else {
                  setState(() {
                    items['selected'] = false;
                    idSelected = 0;
                    paymentSelected = '';
                  });
                }
              },
            );
          },
        )
      ],
    );
  }

  Widget paymentItemCard(
      {String? name,
      int? id,
      String? image,
      String? cost,
      String? selected,
      bool? isSelected,
      Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            padding: id == 2
                ? EdgeInsets.all(10)
                : id == 3
                    ? EdgeInsets.all(10)
                    : EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: id == 2
                  ? Warna.goldHalfBaz
                  : id == 3
                      ? Warna.blueBaz
                      : Colors.grey.shade300,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                image.toString(),
                fit: BoxFit.cover,
                color: id == 3
                    ? Colors.white
                    : id == 2
                        ? Colors.white
                        : null,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toString(),
                  style: TextStyle(fontSize: 17),
                ),
                selected == ''
                    ? Container()
                    : Text(
                        selected.toString(),
                        style: TextStyle(
                            color: Warna.blueBaz,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text('Biaya Admin ' + currText(text: cost.toString()))
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Icon(
              isSelected == true ? Icons.circle : Icons.circle_outlined,
              color: Warna.blueBaz,
            ),
          )
        ],
      ),
    );
  }

  methodMenuListItems({int indexselected = 0}) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.50,
        maxHeight: MediaQuery.of(context).size.height * 0.80,
      ),
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Pilih',
              style: TextStyle(
                  color: Warna.blueBaz,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: bankList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemBuilder: (context, i) {
                    final items = bankList[i];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          paymentMethodList[indexselected]['selected method'] =
                              items['name'];
                          paymentSelected = items['code'];
                        });
                        if (idSelected == 2) {
                          getAdminCostInfo(4000);
                        } else {
                          getAdminCostInfo(2000);
                        }
                        for (int indx = 0; indx < checkoutList.length; indx++) {
                          if (checkoutList[indx]['subtotal'] != 0 &&
                              totalPrice > checkoutList[indx]['subtotal']) {
                            setState(() {
                              itsReady = true;
                            });
                          } else if (checkoutList[indx]['subtotal'] != 0 &&
                              totalPrice >= checkoutList[indx]['subtotal'] &&
                              checkoutList.length < 2) {
                            setState(() {
                              itsReady = true;
                            });
                          }
                        }

                        log(paymentMethodList[indexselected]['selected method']
                            .toString());
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              child: Image.asset(
                                  'assets/BANKCODE/${items['code']}.png'),
                            ),
                            Spacer(),
                            Text(
                              items['name'],
                              style: TextStyle(
                                  color: Warna.blueBaz,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
