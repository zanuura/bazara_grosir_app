import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/order_detail.dart';
import 'package:product_groceries/widgets/custom_text.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedMenu = 'Semua';
  List<Map<String, dynamic>> filterOrderList = [];

  @override
  void initState() {
    super.initState();
    onFilterOrder('');
  }

  onFilterOrder(search) {
    log(search);
    if (filterOrderList.isNotEmpty) {
      setState(() {
        filterOrderList = [];
      });
      setState(() {
        filterOrderList = orderList
            .where((map) => map.values.any(
                (value) => value != null && value.toString().contains(search)))
            .toList();
      });
      log('case 1');
    } else {
      setState(() {
        filterOrderList = orderList
            .where((map) => map.values.any(
                (value) => value != null && value.toString().contains(search)))
            .toList();
      });
      log('case 2');
    }

    log("return : " + filterOrderList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Order'),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              children: [
                filterBox(
                  textValue: 'Semua',
                  value: selectedMenu,
                  ontap: () {
                    setState(() {
                      selectedMenu = 'Semua';
                      onFilterOrder(
                          selectedMenu == 'Semua' ? '' : selectedMenu);
                    });
                  },
                ),
                filterBox(
                  textValue: 'Menunggu Pembayaran',
                  value: selectedMenu,
                  ontap: () {
                    setState(() {
                      selectedMenu = 'Menunggu Pembayaran';
                      onFilterOrder(selectedMenu);
                    });
                  },
                ),
                filterBox(
                  textValue: 'Order Berjalan',
                  value: selectedMenu,
                  ontap: () {
                    setState(() {
                      selectedMenu = 'Order Berjalan';
                      onFilterOrder(selectedMenu);
                    });
                  },
                ),
                filterBox(
                  textValue: 'Selesai',
                  value: selectedMenu,
                  ontap: () {
                    setState(() {
                      selectedMenu = 'Selesai';
                      onFilterOrder(selectedMenu);
                    });
                  },
                ),
                filterBox(
                  textValue: 'Dibatalkan',
                  value: selectedMenu,
                  ontap: () {
                    setState(() {
                      selectedMenu = 'Dibatalkan';
                      onFilterOrder(selectedMenu);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: filterOrderList.length,
        scrollDirection: Axis.vertical,
        // reverse: true,
        // dragStartBehavior: DragStartBehavior.down,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemBuilder: (context, index) {
          final item = filterOrderList.reversed.toList()[index];
          return filterOrderList.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 50),
                  height: 300,
                  // width: 200,
                  child: Image.asset(
                    'assets/onboard_image/bazara_animasi_1.png',
                    fit: BoxFit.fitHeight,
                  ))
              : filterCardItem(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetails(
                            orderId: item['id'],
                            indexOrder: index,
                          ),
                        ));
                  },
                  image: item['image'],
                  produk: item['produk'],
                  status: item['status'],
                  qty: item['qty'].toString(),
                  total: item['total'].toString(),
                );
        },
      ),
    );
  }

  Widget filterBox({String? textValue, String? value, Function()? ontap}) {
    bool isSelected = value == textValue;
    return FittedBox(
      child: InkWell(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: EdgeInsets.all(8),
          // height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? Warna.goldHalfBaz : Warna.blueHalfBaz,
          ),
          child: Text(
            textValue.toString(),
            style: TextStyle(
                color: isSelected ? Colors.white : Warna.blueBaz,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget filterCardItem(
      {String? status,
      String? image,
      String? produk,
      String? qty,
      String? total,
      Function()? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Warna.goldHalfBaz, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                      DateTime.now().toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 40,
                  child: filterBox(
                    textValue: status,
                    value: status,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 18,
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: onTap,
              child: Row(
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
                          image.toString(),
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
                        produk.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "x " + qty.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
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
                Text(
                  'Total Belanja',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  currText(text: total.toString()),
                  style: TextStyle(
                    color: Warna.blueBaz,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
