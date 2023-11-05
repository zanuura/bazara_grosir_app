import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/checkout_screen.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/widgets/custom_text.dart';

class Pengirimanpage extends StatefulWidget {
  const Pengirimanpage({super.key});

  @override
  State<Pengirimanpage> createState() => _PengirimanpageState();
}

class _PengirimanpageState extends State<Pengirimanpage> {
  int shippingCost = 0;
  int productPrice = 0;
  int totalCost = 0;
  bool itsReady = false;

  totalSum(int cost, int price) {
    setState(() {
      totalCost = cost + price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rumah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pilih alamat lain',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Warna.blueBaz),
                )
              ],
            ),
            subtitle: Text(
                'Jalan Asgardihat Kec.Konoha Kab.Atlantis, kampung neraka, blok AZ no 69'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tambah atau edit alamatt',
                style: TextStyle(color: Warna.goldBaz),
              )
            ],
          ),
          Divider(
            color: Warna.blueQuarterBaz,
            height: 20,
            thickness: 5,
          ),
          ListView.builder(
            itemCount: checkoutList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = checkoutList[index];
              return shippingProductCard(
                context: context,
                image: item['image'],
                produk: item['produk'],
                harga: currText(
                  text: item['harga'].toString(),
                ),
                qty: item['qty'].toString() + " Barang",
                indexShipping: index,
                // subTotal: subtotal[index].toString(),
                // shipping: shippingSelected,
              );
            },
          )
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          color: Warna.blueBaz,
          onPressed: () {
            setState(() {
              checkoutList.clear();
            });
            log(checkoutList.toString());
            Navigator.pop(context, 'clear');
          },
        ),
        title: Text(
          'Pengiriman',
          style: TextStyle(color: Warna.blueBaz),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Warna.goldHalfBaz,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Harga'),
                  Text(
                    totalCost == 0
                        ? '---'
                        : currText(text: totalCost.toString()),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !itsReady ? Colors.grey.shade300 : Warna.blueBaz,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: !itsReady
                      ? () {}
                      : () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CheckoutScreen();
                            },
                          ));
                        },
                  child: Text(
                    'Lanjut Pembayaran',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }

  shippingProductCard({
    BuildContext? context,
    int indexShipping = 0,
    String? image,
    String? produk,
    String? qty,
    String? harga,
    String? subTotal,
    List<Map<String, dynamic>>? shipping,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(
                Icons.store,
                color: Warna.blueBaz,
              ),
              SizedBox(
                width: 5,
              ),
              Text('nama toko'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Column(
                children: [
                  Text('data'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(produk.toString()),
                  Text(qty.toString()),
                  Text(harga.toString())
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Warna.goldQuarterBaz,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //side: BorderSide(color: Colors.grey.shade300, width: 2),
                  )),
              onPressed: () {
                menuPengiriman(
                    ctx: context,
                    indexSelected: indexShipping,
                    selected: shipping);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    checkoutList[indexShipping]['pengiriman'] == ''
                        ? "Pilih Pengiriman"
                        : "${checkoutList[indexShipping]['pengiriman']} ${currText(text: checkoutList[indexShipping]['biaya pengiriman'].toString())}",
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal'),
              Text(
                // totalCost == 0 ? '---' : totalCost.toString(),
                // subTotal.toString(),
                checkoutList[indexShipping]['subtotal'] == null
                    ? '-'
                    : currText(
                        text:
                            checkoutList[indexShipping]['subtotal'].toString()),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        Divider(
          color: Warna.blueQuarterBaz,
          height: 20,
          thickness: 5,
        ),
      ],
    );
  }

  menuPengiriman(
      {BuildContext? ctx,
      int indexSelected = 0,
      List<Map<String, dynamic>>? selected}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.50,
        maxHeight: MediaQuery.of(context).size.height * 0.80,
      ),
      context: context,
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text('Pilih Pengiriman'),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: shippingCostList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        if (checkoutList[indexSelected]['subtotal'] != 0) {
                          setState(() {
                            checkoutList[indexSelected]['subtotal'] = 0;
                            totalCost = 0;
                          });
                        }

                        setState(() {
                          checkoutList[indexSelected]['pengiriman'] =
                              shippingCostList[index]['name'];
                          checkoutList[indexSelected]['biaya pengiriman'] =
                              shippingCostList[index]['cost'];
                          checkoutList[indexSelected]['subtotal'] =
                              shippingCostList[index]['cost'] +
                                  checkoutList[indexSelected]['harga'];
                          checkoutList.forEach((item) {
                            totalCost += int.parse(item["subtotal"].toString());
                          });
                        });

                        if (checkoutList[indexSelected]['subtotal'] != 0 &&
                            totalCost >
                                checkoutList[indexSelected]['subtotal']) {
                          setState(() {
                            itsReady = true;
                          });
                        } else if (checkoutList[indexSelected]['subtotal'] !=
                                0 &&
                            totalCost >=
                                checkoutList[indexSelected]['subtotal'] &&
                            checkoutList.length < 2) {
                          setState(() {
                            itsReady = true;
                          });
                        }

                        // totalSum(shippingCostList[index]['cost'], 20000);

                        Navigator.pop(context);
                      },
                      title: Text(
                        shippingCostList[index]['name'],
                        style: TextStyle(
                          color: Warna.blueBaz,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(currText(
                          text: shippingCostList[index]['cost'].toString())),
                    ),
                    Divider(
                      color: Warna.blueQuarterBaz,
                      thickness: 2,
                    )
                  ],
                );
              },
            ))
          ],
        );
      },
    );
  }
}
