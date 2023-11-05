import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/product_detail.dart';
import 'package:product_groceries/widgets/product_card.dart';

class kategoriScreen extends StatefulWidget {
  var kategori;
  kategoriScreen({super.key, this.kategori});

  @override
  State<kategoriScreen> createState() => _kategoriScreenState();
}

class _kategoriScreenState extends State<kategoriScreen> {
  var selectedMenu;
  List<Map<String, dynamic>> produkKategori = [];

  @override
  void initState() {
    super.initState();

    if (widget.kategori != null) {
      setState(() {
        selectedMenu = widget.kategori;
      });
      getProdukByCategory(widget.kategori);
    } else {
      getProdukByCategory('');
    }
  }

  getProdukByCategory(category) {
    if (produkKategori.isNotEmpty) {
      setState(() {
        produkKategori = [];
      });
      setState(() {
        produkKategori = dataProduk
            .where((map) => map.values.any((value) =>
                value != null && value.toString().contains(category)))
            .toList();
      });
      log('case 1');
    } else {
      setState(() {
        produkKategori = dataProduk
            .where((map) => map.values.any((value) =>
                value != null && value.toString().contains(category)))
            .toList();
      });
      log('case 2');
    }

    log("return : " + produkKategori.toString());
  }

  onTapSelected(menu) {
    setState(() {
      selectedMenu = menu;
    });

    getProdukByCategory(selectedMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semua Kategori"),
        backgroundColor: MyTheme.accent_color,
      ),
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.30,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                itemCount: kategoriList.length,
                itemBuilder: (context, index) {
                  final items = kategoriList[index];
                  return menuCardItems(
                    name: items['name'],
                    code: items['code'],
                    image: items['image'],
                    onTap: () {
                      onTapSelected(items['code']);
                    },
                  );
                },
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: AlignedGridView.count(
              itemCount: produkKategori.length,
              // controller: _featuredProductScrollController,
              crossAxisCount: 2,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return productCard(
                  ontap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductDetail(
                        id: produkKategori[index]['id'],
                        image: produkKategori[index]['image'],
                        productName: produkKategori[index]['produk'],
                        productPrice: produkKategori[index]['harga'],
                        priceDiscount: produkKategori[index]['diskon'],
                        indexProduk: produkKategori[index],
                      );
                    }));
                  },
                  image: produkKategori[index]['image'],
                  productName: produkKategori[index]['produk'],
                  productPrice: produkKategori[index]['harga'],
                  productDiskon: produkKategori[index]['diskon'],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget menuCardItems({
    String? name,
    String? image,
    String? code,
    Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selectedMenu == code
            ? Colors.white
            : Warna.goldBaz.withOpacity(0.50),
      ),
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(5),
      // height: 100,
      // width: 100,
      child: InkWell(
        onTap: onTap,
        splashColor: MyTheme.soft_accent_color,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              image.toString(),
              height: 70,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 15),
            Text(name.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                )),
          ],
        )),
      ),
    );
  }

  oldLeftBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMenu == 'makanan'
                  ? Colors.white
                  : Warna.goldBaz.withOpacity(0.50),
            ),
            margin: EdgeInsets.all(4),
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                onTapSelected('makanan');
              },
              splashColor: MyTheme.soft_accent_color,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/dashboard/bahan_makanan.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 5),
                  Text("Bahan Makanan",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 12, 12, 12))),
                ],
              )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMenu == 'produk_segar'
                  ? Colors.white
                  : Warna.goldBaz.withOpacity(0.50),
            ),
            margin: EdgeInsets.all(4),
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                onTapSelected('produk_segar');
              },
              splashColor: MyTheme.soft_accent_color,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/dashboard/product_fresh.png',
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 15),
                  Text("Produk Segar",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 12, 12, 12))),
                ],
              )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMenu == 'rumah_tangga'
                  ? Colors.white
                  : Warna.goldBaz.withOpacity(0.50),
            ),
            margin: EdgeInsets.all(4),
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                onTapSelected('rumah_tangga');
              },
              splashColor: MyTheme.soft_accent_color,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/dashboard/rumah_tangga.png',
                    width: 65,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 5),
                  Text("Rumah Tangga",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 12, 12, 12))),
                ],
              )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMenu == 'susu_telur'
                  ? Colors.white
                  : Warna.goldBaz.withOpacity(0.50),
            ),
            margin: EdgeInsets.all(4),
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                onTapSelected('susu_telur');
              },
              splashColor: MyTheme.soft_accent_color,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/dashboard/susu_telur.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text("Olahan Susu & Telur",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 12, 12, 12))),
                ],
              )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMenu == 'minuman_kopi'
                  ? Colors.white
                  : Warna.goldBaz.withOpacity(0.50),
            ),
            margin: EdgeInsets.all(4),
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                onTapSelected('minuman_kopi');
              },
              splashColor: MyTheme.soft_accent_color,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/dashboard/minuman_soda.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 5),
                  Text("Minuman, Kopi ...",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 12, 12, 12))),
                ],
              )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMenu == 'produk_beku'
                  ? Colors.white
                  : Warna.goldBaz.withOpacity(0.50),
            ),
            margin: EdgeInsets.all(4),
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                onTapSelected('produk_beku');
              },
              splashColor: MyTheme.soft_accent_color,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/dashboard/Frozen_Food.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 15),
                  Text("Produk Beku",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 12, 12, 12))),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
