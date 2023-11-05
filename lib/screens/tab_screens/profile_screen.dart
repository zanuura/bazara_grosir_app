import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Akun',
          style: TextStyle(color: Warna.blueBaz),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          akunInfo(),
          SizedBox(
            height: 20,
          ),
          walletAddress(),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
                  Text(
                    'Toko Saya',
                    style: TextStyle(
                        color: Warna.blueBaz,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Warna.blueBaz,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          myDivider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: h1Text(text: 'Aktivitas Saya'),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_trans.png',
                width: 35,
                height: 35),
            title: Text('Daftar Transaksi'),
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_heart.png',
                width: 35,
                height: 35),
            title: Text('Favorit'),
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_chat.png',
                width: 35,
                height: 35),
            title: Text('Chat'),
          ),
          SizedBox(
            height: 20,
          ),
          myDivider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: h1Text(text: 'Bazara'),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_i.png', width: 35, height: 35),
            title: Text('Tentang Kami'),
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_tos.png',
                width: 35,
                height: 35),
            title: Text('Syarat dan ketentuan'),
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_pipo.png',
                width: 35,
                height: 35),
            title: Text('Kebjakan privasi'),
          ),
          SizedBox(
            height: 20,
          ),
          myDivider(),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_akun.png',
                width: 35,
                height: 35),
            title: Text('Pengaturan akun'),
          ),
          ListTile(
            onTap: () {},
            leading: customIconBox(
                iconPath: 'assets/baz_icons/baz_out.png',
                width: 35,
                height: 35),
            title: Text(
              'Keluar Akun',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget myDivider() {
    return Divider(
      thickness: 8,
      color: Colors.grey.shade200,
    );
  }

  Widget h1Text({String? text}) {
    return Text(
      text!,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }

  Widget customIconBox({String? iconPath, double? height, double? width}) {
    return Container(
      padding: EdgeInsets.all(8),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Warna.blueHalfBaz,
      ),
      child: Center(
        child: Image.asset(
          iconPath!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget akunInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: Colors.white,
          ),
          child: Image.asset(
            'assets/baz_icons/baz_profile_back.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '089787868787',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'bazara.mail.com',
                style: TextStyle(fontSize: 16),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget walletAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Warna.blueHalfBaz,
              ),
              child: Center(
                child: Image.asset(
                  'assets/baz_icons/baz_lock.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Daftar Alamat',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Warna.blueHalfBaz,
              ),
              child: Center(
                child: Image.asset(
                  'assets/baz_icons/baz_wallet.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dompet Bazara',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
