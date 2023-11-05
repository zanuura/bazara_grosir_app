import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/tab_screens/main_screen.dart';
import 'package:product_groceries/widgets/custom_text.dart';
import 'dart:async';

class PaymentScreen extends StatefulWidget {
  List<int> orderId = [];
  bool? backPop = false;
  int orderIndex = 0;
  PaymentScreen(
      {super.key, required this.orderId, this.backPop, this.orderIndex = 0});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Map<String, dynamic>> orderData = [];
  int total = 0;
  String paymentMethod = '';
  String paymentCode = '';

  Timer? _timer;
  int _secondsRemaining = 24 * 60 * 60; // 24 hours in seconds

  @override
  void initState() {
    super.initState();
    getOrderData();
    startTimer();
  }

  getOrderData() {
    orderData =
        orderList.where((data) => widget.orderId.contains(data['id'])).toList();
    setState(() {});

    orderData.forEach((itms) {
      total += int.parse(itms['total'].toString());
      paymentMethod = itms['pembayaran'];
    });

    log(orderData.toString());
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  paymentDone() {
    orderList[widget.orderIndex]['status'] = 'Order Berjalan';
    setState(() {});
    log(orderList[widget.orderIndex].toString());
    Navigator.pop(context, 'Order Berjalan');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.backPop == true
          ? () {
              Navigator.pop(context);

              return Future.value(true);
            }
          : () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return MainScreen();
                },
              ));
              return Future.value(false);
            },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Warna.blueBaz,
            onPressed: widget.backPop == true
                ? () {
                    Navigator.pop(context);
                  }
                : () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return MainScreen();
                      },
                    ));
                  },
          ),
          title: Text(
            'Pembayaran',
            style: TextStyle(color: Warna.blueBaz),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            headerPayment(),
            methodInfo(),
            howToPay(),
            SizedBox(
              height: 60,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          height: 60,
          child: ElevatedButton(
            onPressed: widget.backPop == false && widget.orderIndex == 0
                ? () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return MainScreen();
                      },
                    ));
                  }
                : () {
                    paymentDone();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Warna.goldHalfBaz,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Sudah Bayar',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerPayment() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.grey,
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    height: 50,
                    child: Image.asset(
                      'assets/onboard_image/bazara_log.png',
                      fit: BoxFit.fitHeight,
                    )),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.white,
            )
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    // offset: 5,
                    color: Colors.grey,
                    spreadRadius: 5,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Bayar dalam ' + formatTime(_secondsRemaining),
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  currText(text: total.toString()),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Warna.blueBaz),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Kode Pembayaran',
                //       style: TextStyle(fontSize: 15),
                //     ),
                //     Text(
                //       '6576467867687645',
                //       style: TextStyle(
                //           color: Warna.blueBaz,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget methodInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            paymentMethod.toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Warna.blueBaz),
          ),
          SizedBox(
            height: 35,
            child: Image.asset(
              'assets/BANKCODE/${paymentMethod}.png',
              fit: BoxFit.fitHeight,
            ),
          )
        ],
      ),
    );
  }

  Widget howToPay() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Cara Bayar',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.grey.shade300,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1. Buka Aplikasi e-Banking'),
              Text('2. Masukan password'),
              Text('3. Plih menu pembayaran belanja online'),
              Text('4. Masukkan kode pembayaran'),
              Text('5. Tap tombol submit'),
              Text('6. Masukkan pin anda'),
              Text('7. Selesai'),
              Text(' '),
              Text('Selamat pesanan anda akan segera di proses'),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        )
      ],
    );
  }
}
