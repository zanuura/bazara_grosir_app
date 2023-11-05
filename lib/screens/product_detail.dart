import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/keranjang.dart';
import 'package:product_groceries/screens/review_page.dart';
import 'package:product_groceries/widgets/custom_text.dart';
import 'package:product_groceries/widgets/product_card.dart';

class ProductDetail extends StatefulWidget {
  var id;
  var image;
  var productName;
  var productPrice;
  var priceDiscount;
  var indexProduk;
  ProductDetail(
      {super.key,
      this.id,
      this.image,
      this.productName,
      this.priceDiscount,
      this.productPrice,
      this.indexProduk});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int productInCart = 1;
  bool favorited = false;
  bool imageFull = false;
  int currentImage = 0;
  String iconsPath = 'assets/baz_icons';

  @override
  void initState() {
    super.initState();
    print(widget.indexProduk);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: BackButton(color: Warna.blueBaz),
              title: Text(
                'Product Detail',
                style: TextStyle(color: Warna.blueBaz),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                SizedBox(
                  height: 38,
                  width: 38,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Keranjang(
                              fromTab: false,
                            ),
                          ));
                    },
                    icon: Image.asset(
                      '$iconsPath/baz_cart.png',
                    ),
                    color: Warna.blueBaz,
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(vertical: 3),
                              itemBuilder: (context, index) {
                                return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.11,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 6),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          imageFull = true;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          widget.image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageFull = true;
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    widget.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                              color: Warna.blueBaz,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            if (favorited == true) {
                              setState(() {
                                favorited = false;
                              });
                            } else {
                              setState(() {
                                favorited = true;
                              });
                            }
                          },
                          child: Icon(
                              favorited == true
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color:
                                  favorited == true ? Colors.red : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Text(
                          currText(text: widget.productPrice.toString()),
                          style: TextStyle(
                              color: Warna.goldBaz,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              currText(text: widget.priceDiscount.toString()),
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.star,
                          color: Warna.goldBaz,
                        ),
                      ),
                      Text(
                        '4.0 | terjual 654',
                        style: TextStyle(
                          color: Warna.goldBaz,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.location_on,
                          color: Warna.blueBaz,
                        ),
                      ),
                      Text(
                        'Bandung, Kota',
                        style: TextStyle(
                          color: Warna.blueBaz,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Warna.goldHalfBaz),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewPage(
                                  productImage: widget.image,
                                  productName: widget.productName,
                                  productPrice: widget.productPrice,
                                ),
                              ));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ulasan ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(1)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                  Divider(
                    thickness: 7,
                    height: 15,
                    color: Colors.grey[200],
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("Deskripsi Produk",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Kondisi',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Baru',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Min.Pemesanan',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '1 Dus',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Kategori',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Sembako',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            ' ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Text(
                              'Baca Selengkapnya',
                              style: TextStyle(
                                  color: Warna.blueBaz,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 7,
                    height: 15,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Text(
                          'Jumlah :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                        ),
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
                                            if (productInCart > 0) {
                                              productInCart--;
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
                                productInCart.toString(),
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
                                            productInCart++;
                                          },
                                        )
                                      })
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '(0 tersedia)',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total Harga :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            currText(
                                text: (widget.productPrice * productInCart)
                                    .toString()),
                            style: TextStyle(
                                color: Warna.blueBaz,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 7,
                    height: 15,
                    color: Colors.grey[200],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Center(child: Icon(Icons.store_outlined)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    title: Text('Nama toko'),
                    subtitle: Text('Alamat Toko'),
                  ),
                  Divider(
                    thickness: 7,
                    height: 15,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Lainnya di Toko ini',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      itemCount: dataProduk.length,
                      // controller: _featuredProductScrollController,
                      scrollDirection: Axis.horizontal,
                      dragStartBehavior: DragStartBehavior.start,
                      reverse: false,
                      padding: EdgeInsets.all(8),
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return productCard(
                          ontap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDetail(
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
                  ),
                  Divider(
                    thickness: 7,
                    height: 15,
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
                child: Container(
              // height: 70,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Warna.blueQuarterBaz),
                        onPressed: () {},
                        child: Text(
                          'Chat Penjual',
                          style: TextStyle(
                              color: Warna.blueBaz,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Warna.blueBaz),
                        onPressed: () {
                          if (productInCart > 0) {
                            cartProduct.add({
                              'id': widget.id,
                              'produk': widget.productName,
                              'image': widget.image,
                              'harga': widget.productPrice,
                              'diskon': widget.priceDiscount,
                              'qty': productInCart,
                              'selected': false,
                            });
                            addedToCard();
                          }
                        },
                        child: Text(
                          'Tambah Keranjang',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )),
          ),
          imageFull == true ? imageFullScreen() : Container(),
        ],
      ),
    );
  }

  addedToCard() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Ditambah ke Keranjang'),
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        // backgroundColor: Colors.grey[300],
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        child: Image.asset('${widget.image}'),
                      ),
                      title: Text('${widget.productName} x ${productInCart}'),
                      subtitle: Text(currText(
                          text: '${widget.productPrice * productInCart} ')),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Warna.blueQuarterBaz),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Keranjang(
                                  fromTab: false,
                                ),
                              ));
                        },
                        child: Text(
                          'Lihat Keranjang',
                          style: TextStyle(
                              color: Warna.blueBaz,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget imageFullScreen() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
            child: InkWell(
              onTap: () {
                setState(() {
                  imageFull = false;
                });
              },
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      setState(() {
                        currentImage = value + 1;
                      });
                      log(currentImage.toString());
                    },
                    itemBuilder: (context, index) {
                      return Container(
                          height: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              widget.image,
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Gambar ' + currentImage.toString() == 0
                      ? '1'
                      : currentImage.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
