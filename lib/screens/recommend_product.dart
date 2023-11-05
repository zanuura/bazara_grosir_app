import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/product_detail.dart';
import 'package:product_groceries/widgets/product_card.dart';

class RecommendProductPage extends StatefulWidget {
  const RecommendProductPage({super.key});

  @override
  State<RecommendProductPage> createState() => _RecommendProductPageState();
}

class _RecommendProductPageState extends State<RecommendProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.blueBaz,
        title: Text('Produk Rekomendasi'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          AlignedGridView.count(
            itemCount: dataProduk.length,
            crossAxisCount: 3,
            // padding: EdgeInsets.all(8),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            itemBuilder: (context, index) {
              return productCard(
                ontap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
        ],
      )),
    );
  }
}
