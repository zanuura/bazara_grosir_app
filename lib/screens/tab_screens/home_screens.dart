import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/product_detail.dart';
import 'package:product_groceries/screens/promo_product.dart';
import 'package:product_groceries/screens/recommend_product.dart';
import 'package:product_groceries/screens/search_screen.dart';
import 'package:product_groceries/screens/semua_kategori.dart';
import 'package:product_groceries/screens/terlaris_product.dart';
import 'package:product_groceries/widgets/product_card.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  get onTap => null;
  ScrollController mainScrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
    print(dataProduk);
    mainScrollController.addListener(() {
      if (mainScrollController.offset > 60 && !isScrolled) {
        setState(() {
          isScrolled = true;
        });
      } else if (mainScrollController.offset < 60 && isScrolled) {
        setState(() {
          isScrolled = false;
        });
      }
    });
  }

  Widget customIconBox({String? iconPath, double? height, double? width}) {
    return Container(
      padding: EdgeInsets.all(6),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey.withOpacity(0.90),
      ),
      child: Center(
        child: Image.asset(
          iconPath!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.blueBaz,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        // title: Text("Dashboard"),
        actions: isScrolled
            ? []
            : [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.90),
                          // foregroundColor: Warna.goldHalfBaz,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Store Name',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      customIconBox(
                          iconPath: 'assets/baz_icons/baz_chat_gold.png',
                          width: 30,
                          height: 30),
                      SizedBox(
                        width: 10,
                      ),
                      customIconBox(
                          iconPath: 'assets/baz_icons/baz_bel_gold.png',
                          width: 30,
                          height: 30),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ],
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            // decoration: BoxDecoration(
            //   color: Warna.blueBaz,
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(25),
            //   ),
            // ),
            child: TextField(
              onSubmitted: (text) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchScreen(
                      searchValue: text,
                    );
                  },
                )).then((value) {
                  if (value == 'done') {
                    setState(() {
                      searchController.text = '';
                    });
                  }
                });
              },
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.search,
              controller: searchController,
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  hintText: 'Mau beli apa?',
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: Warna.blueBaz,
                    size: 25,
                  ),
                  suffixIcon: searchController.text == ''
                      ? null
                      : InkWell(
                          onTap: () {
                            setState(() {
                              searchController.text = '';
                            });
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: Warna.blueBaz,
                            size: 25,
                          ),
                        ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Warna.blueBaz, width: 2.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.white, width: 2))),
            ),
          ),
          preferredSize: Size.fromHeight(isScrolled ? 5 : 60),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          controller: mainScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    'Produk Sesuai Kategori',
                    style: TextStyle(
                        fontSize: (20),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return kategoriScreen();
                            },
                          ));
                        },
                        child: Text(
                          "semua kategori",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: MyTheme.accent_color),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return kategoriScreen(
                              kategori: 'Produk Segar',
                            );
                          },
                        ));
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
                          SizedBox(height: 20),
                          Text("Produk Segar",
                              style: new TextStyle(
                                  fontSize: 15.0, color: Color(0xff778899))),
                        ],
                      )),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return kategoriScreen(
                              kategori: 'Rumah Tangga',
                            );
                          },
                        ));
                      },
                      splashColor: MyTheme.soft_accent_color,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/dashboard/rumah_tangga.png',
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Rumah Tangga",
                            style: new TextStyle(
                                fontSize: 15, color: Color(0xff778899)),
                          )
                        ],
                      )),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return kategoriScreen(
                              kategori: 'Bahan Makanan',
                            );
                          },
                        ));
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
                          SizedBox(height: 15),
                          Text(
                            "Bahan Makanan",
                            style: new TextStyle(
                                fontSize: 15, color: Color(0xff778899)),
                          )
                        ],
                      )),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return kategoriScreen(
                              kategori: 'Susu Telur',
                            );
                          },
                        ));
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
                          SizedBox(height: 15),
                          Text(
                            "Olahan Susu & Telur",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 15, color: Color(0xff778899)),
                          )
                        ],
                      )),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return kategoriScreen(
                              kategori: 'Produk Beku',
                            );
                          },
                        ));
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
                          Text(
                            "Produk Beku",
                            style: new TextStyle(
                                fontSize: 15, color: Color(0xff778899)),
                          )
                        ],
                      )),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return kategoriScreen(
                              kategori: 'Jajanan',
                            );
                          },
                        ));
                      },
                      splashColor: Warna.redBaz,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/dashboard/minuman_soda.png',
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Minuman, Kopi ..",
                            style: new TextStyle(
                                fontSize: 15, color: Color(0xff778899)),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rekomendasi Kami',
                    style: TextStyle(
                        fontSize: (20),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RecommendProductPage();
                          },
                        ));
                      },
                      child: Text(
                        'Lebih banyak',
                        style: TextStyle(color: MyTheme.accent_color),
                      ))
                ],
              ),
              SizedBox(height: 15),
              AlignedGridView.count(
                itemCount: 3,
                crossAxisCount: 3,
                // padding: EdgeInsets.all(8),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return productCard(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetail(
                          id: dataProduk[index]['id'],
                          image: dataProduk[index]['image'],
                          productName: dataProduk[index]['produk'],
                          productPrice: dataProduk[index]['harga'],
                          priceDiscount: dataProduk[index]['diskon'],
                          indexProduk: dataProduk[index],
                        );
                      }));
                    },
                    image: dataProduk[index]['image'],
                    productName: dataProduk[index]['produk'],
                    productPrice: dataProduk[index]['harga'],
                    productDiskon: dataProduk[index]['diskon'],
                  );
                },
              ),
              SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PromoProductPage();
                      },
                    ));
                  },
                  child: Text(
                    'Produk Promo',
                    style: TextStyle(
                        fontSize: (20),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 14,
              ),
              AlignedGridView.count(
                itemCount: 3,
                // controller: _featuredProductScrollController,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return productCard(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetail(
                          id: dataProduk[index]['id'],
                          image: dataProduk[index]['image'],
                          productName: dataProduk[index]['produk'],
                          productPrice: dataProduk[index]['harga'],
                          priceDiscount: dataProduk[index]['diskon'],
                          indexProduk: dataProduk[index],
                        );
                      }));
                    },
                    image: dataProduk[index]['image'],
                    productName: dataProduk[index]['produk'],
                    productPrice: dataProduk[index]['harga'],
                    productDiskon: dataProduk[index]['diskon'],
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return TerlarisProductPage();
                      },
                    ));
                  },
                  child: Text(
                    'Produk Terlaris',
                    style: TextStyle(
                        fontSize: (20),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(height: 14),
              AlignedGridView.count(
                itemCount: dataProduk.length,
                // controller: _featuredProductScrollController,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return productCard(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetail(
                          id: dataProduk[index]['id'],
                          image: dataProduk[index]['image'],
                          productName: dataProduk[index]['produk'],
                          productPrice: dataProduk[index]['harga'],
                          priceDiscount: dataProduk[index]['diskon'],
                          indexProduk: dataProduk[index],
                        );
                      }));
                    },
                    image: dataProduk[index]['image'],
                    productName: dataProduk[index]['produk'],
                    productPrice: dataProduk[index]['harga'],
                    productDiskon: dataProduk[index]['diskon'],
                  );
                },
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
