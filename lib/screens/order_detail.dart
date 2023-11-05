import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/payment_screen.dart';
import 'package:product_groceries/widgets/custom_text.dart';

class OrderDetails extends StatefulWidget {
  int? orderId;
  int? indexOrder;
  OrderDetails({super.key, this.orderId, this.indexOrder});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Map<String, dynamic>> detailOrder = [];

  @override
  void initState() {
    super.initState();
    log(widget.orderId.toString());
    getDetailOrder(widget.orderId);
  }

  getDetailOrder(id) {
    detailOrder = orderList.where((map) => map['id'] == id).toList();
    setState(() {});

    log(detailOrder.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Warna.blueBaz),
        title: Text(
          'Detail Pesanan',
          style: TextStyle(color: Warna.blueBaz),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 20,
          ),
          tileStoryOrder(),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            detailOrder[0]['status'].toString().toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tanggal Pembelian',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  DateTime.now().toString(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Warna.blueBaz),
                ),
              ],
            ),
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
                  detailOrder[0]['invoice'],
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Warna.blueBaz),
                ),
                Text(
                  'Lihat Invoice',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Warna.goldHalfBaz),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 8,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Detail Produk',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Warna.blueHalfBaz, width: 1.5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
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
                          DateTime.now().toString(),
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            detailOrder[0]['image'].toString(),
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          detailOrder[0]['produk'].toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${detailOrder[0]['qty']} x " +
                              currText(
                                  text: (detailOrder[0]['total'] /
                                          detailOrder[0]['qty'])
                                      .round()
                                      .toString()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currText(text: detailOrder[0]['total'].toString()),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Warna.goldHalfBaz,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 8,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Detail Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                Expanded(
                  child: Text(
                    'Kurir Pengiriman',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    detailOrder[0]['pengiriman'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'No Resi',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    '76875764676897976',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Alamat Pengiriman',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    detailOrder[0]['alamat'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 8,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Detail Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Metode Pembayaran',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 25,
                    child: Image.asset(
                      'assets/BANKCODE/${detailOrder[0]['pembayaran']}.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey.shade200,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Harga Produk',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    currText(
                        text: (detailOrder[0]['total'] / detailOrder[0]['qty'])
                            .round()
                            .toString()),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Biaya Administrasi',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    currText(text: detailOrder[0]['biaya admin'].toString()),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Biaya Pengiriman',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    currText(
                        text: detailOrder[0]['biaya pengiriman'].toString()),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey.shade200,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Potongan',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    currText(text: '0'),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey.shade200,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Total Bayar',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Text(
                    currText(text: detailOrder[0]['total'].toString()),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Warna.goldHalfBaz),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Warna.goldHalfBaz,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                  child: Text(
                    'Ajukan Komplain',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: detailOrder[0]['status'] == 'Menunggu Pembayaran'
                      ? () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PaymentScreen(
                                orderId: [detailOrder[0]['id']],
                                backPop: true,
                                orderIndex: widget.orderId! - 1,
                              );
                            },
                          )).then((value) {
                            setState(() {
                              detailOrder[0]['status'] = value;
                            });
                          });
                        }
                      : () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Warna.goldHalfBaz,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                  child: Text(
                    detailOrder[0]['status'] == 'Menunggu Pembayaran'
                        ? 'Bayar'
                        : 'Selesaikan Pesanan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget tileStoryOrder() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/baz_icons/baz_wallet.png',
                  color: Warna.goldHalfBaz,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Divider(
                    indent: 5,
                    endIndent: 2,
                    thickness: 10,
                    color: Warna.goldHalfBaz,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/timeline_icons/box_gold.png',
                  color: Warna.goldHalfBaz,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Divider(
                    indent: 2,
                    endIndent: 2,
                    thickness: 10,
                    color: Warna.goldHalfBaz,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/timeline_icons/car_gold.png',
                  color: Warna.goldHalfBaz,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Divider(
                    indent: 2,
                    endIndent: 5,
                    thickness: 10,
                    color: Warna.goldHalfBaz,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                child: Image.asset(
                  'assets/baz_icons/baz_home_active.png',
                  color: Warna.goldHalfBaz,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
