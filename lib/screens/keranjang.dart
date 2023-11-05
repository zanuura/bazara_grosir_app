import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/pengiriman_page.dart';
import 'package:product_groceries/widgets/custom_text.dart';

class Keranjang extends StatefulWidget {
  Keranjang({required this.fromTab});

  var fromTab = true;

  @override
  State<Keranjang> createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  int totalPrice = 0;
  @override
  void initState() {
    super.initState();
    print(cartList);
    log(cartList.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          leading: widget.fromTab == true
              ? Container()
              : BackButton(color: Warna.blueBaz),
          title: Text(
            'Keranjang',
            style: TextStyle(color: Warna.blueBaz),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          height: 70,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Harga"),
                  Text(currText(text: totalPrice.toString()))
                ],
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: checkoutList.isNotEmpty
                            ? Warna.goldHalfBaz
                            : Colors.grey.shade300,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      if (checkoutList.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pengirimanpage(),
                            )).then((value) {
                          if (value == 'clear') {
                            totalPrice = 0;
                            checkoutList.clear();
                            setState(() {});
                          }
                        });
                      }
                    },
                    child: Text(
                      "Pengiriman",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              )
            ],
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: cartProduct.isEmpty ? 1 : cartProduct.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            int price = 0;
            final isSelected = cartProduct.isEmpty
                ? false
                : cartProduct[index]['selected'] == true;
            // var cartTotal = cartProduct[index] + 1;
            List<TextEditingController> messageController = [];
            for (int i = 0; i < cartProduct.length; i++) {
              messageController.add(TextEditingController());
            }
            return cartProduct.isEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 300,
                    // width: 200,
                    child: Image.asset(
                      'assets/onboard_image/bazara_animasi_1.png',
                      fit: BoxFit.fitHeight,
                    ))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.store,
                              color: Warna.blueBaz,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama Toko'),
                                Text(
                                  'Bandung Kota',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    '${cartProduct[index]['image']}',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  '${cartProduct[index]['produk']}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currText(
                                      text:
                                          '${cartProduct[index]['harga'] * cartProduct[index]['qty']}'),
                                  style: TextStyle(
                                      color: Warna.blueBaz,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'x ${cartProduct[index]['qty']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                if (isSelected == true) {
                                  checkoutList.remove(checkoutList[index]);
                                  setState(() {
                                    // for (var item in checkoutList) {
                                    //   totalPrice -
                                    //       int.parse(item["harga"].toString());
                                    // }
                                    totalPrice = checkoutList.fold(0,
                                        (previousValue, data) {
                                      return previousValue -
                                          int.parse(
                                              (data['harga'] * data['qty'])
                                                  .toString());
                                    });
                                    cartProduct[index]['selected'] = false;
                                  });
                                  log('remove');
                                  log(checkoutList.toString());
                                } else {
                                  checkoutList.add({
                                    'id': cartProduct[index]['id'],
                                    'produk': cartProduct[index]['produk'],
                                    'image': cartProduct[index]['image'],
                                    'harga': cartProduct[index]['harga'] *
                                        cartProduct[index]['qty'],
                                    'diskon': cartProduct[index]['diskon'],
                                    'qty': cartProduct[index]['qty'],
                                    'message': messageController[index].text,
                                    'pengiriman': '',
                                    'biaya pengiriman': 0,
                                    'subtotal': 0,
                                  });
                                  setState(() {
                                    // for (var item in checkoutList) {
                                    //   totalPrice +
                                    //       int.parse(item["harga"].toString());
                                    // }
                                    totalPrice = checkoutList.fold(0,
                                        (previousValue, data) {
                                      return previousValue +
                                          int.parse(
                                              (data['harga'] * data['qty'])
                                                  .toString());
                                    });
                                    cartProduct[index]['selected'] = true;
                                  });
                                  log('added');
                                  log(checkoutList.toString());
                                }
                              },
                              child: Icon(
                                isSelected
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank_rounded,
                                color: isSelected
                                    ? Warna.blueBaz
                                    : Colors.grey.shade500,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: messageController[index],
                          decoration: InputDecoration(
                              labelText: "Pesan",
                              labelStyle: TextStyle(
                                color: Warna.blueBaz,
                              ),
                              isDense: true,
                              enabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Warna.blueBaz, width: 2),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    cartProduct.remove(cartProduct[index]);
                                    checkoutList.remove(checkoutList[index]);
                                    totalPrice = 0;
                                  });
                                  log(cartProduct.toString());
                                  log(checkoutList.toString());
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey.shade500,
                                )),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Warna.goldHalfBaz,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                      onTap: () => {
                                            setState(
                                              () {
                                                if (cartProduct[index]['qty'] >
                                                    0) {
                                                  cartProduct[index]['qty']--;
                                                  checkoutList[index]['qty']--;
                                                  totalPrice = checkoutList
                                                      .fold(0, (previousValue,
                                                          data) {
                                                    return previousValue -
                                                        (double.parse((data[
                                                                        'harga'] /
                                                                    cartProduct[
                                                                            index]
                                                                        ['qty'])
                                                                .toString()))
                                                            .toInt();
                                                  });
                                                  // totalPrice = checkoutList
                                                  //     .fold(0, (previousValue,
                                                  //         data) {
                                                  //   return previousValue -
                                                  //       int.parse(double.parse((data[
                                                  //                       'harga'] /
                                                  //                   cartProduct[
                                                  //                           index]
                                                  //                       ['qty'])
                                                  //               .toString())
                                                  //           .toString());
                                                  // });
                                                }
                                              },
                                            )
                                          }),
                                  Text(
                                    '| ',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  Text(
                                    cartProduct[index]['qty'].toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    ' |',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  InkWell(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onTap: () => {
                                            setState(
                                              () {
                                                cartProduct[index]['qty']++;
                                                totalPrice = checkoutList.fold(
                                                    0, (previousValue, data) {
                                                  return previousValue +
                                                      int.parse((data['harga'] *
                                                              cartProduct[index]
                                                                  ['qty'])
                                                          .toString());
                                                });
                                              },
                                            )
                                          })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Warna.blueQuarterBaz,
                        thickness: 6.5,
                        height: 20,
                      ),
                      // ListTile(
                      //       leading: CircleAvatar(backgroundColor: Colors.grey[300], child: Image.asset('${cartProduct[index]['image']}'),),
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      //       title: Text('${cartProduct[index]['produk']} x ${cartProduct[index]['qty']}'),
                      //       subtitle: Text('${cartProduct[index]['harga'] * cartProduct[index]['qty']}'),
                      //     ),
                      cartProduct.length == index + 1
                          ? SizedBox(
                              height: 100,
                            )
                          : Container(),
                    ],
                  );
          },
        ));
  }
}
