import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';
import 'package:product_groceries/screens/product_detail.dart';
import 'package:product_groceries/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  String? searchValue;
  SearchScreen({super.key, this.searchValue});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchList = [];
  bool _isConditionMet = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_handleTextChange);
    log(widget.searchValue.toString());
    setState(() {
      searchController.text = widget.searchValue!;
    });
    searchLoader(widget.searchValue);
  }

  @override
  void dispose() {
    searchController.removeListener(_handleTextChange);
    searchController.dispose();
    super.dispose();
  }

  String toCamelCase(String input) {
    if (input.isEmpty) {
      return '';
    }

    final words = input.trim().split(' ');
    final result = [words[0].toLowerCase()];

    for (var i = 1; i < words.length; i++) {
      final word = words[i];
      final capitalizedWord =
          '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      result.add(capitalizedWord);
    }

    return result.join('');
  }

  void _handleTextChange() {
    String text = searchController.text;
    // Apply your condition here
    if (text.length >= 5) {
      setState(() {
        _isConditionMet = true;
      });
    } else {
      setState(() {
        _isConditionMet = false;
      });
    }
  }

  searchLoader(search) {
    log(search);
    if (searchList.isNotEmpty) {
      setState(() {
        searchList = [];
      });
      setState(() {
        searchList = dataProduk
            .where((map) => map.values.any((value) =>
                value != null &&
                value.toString().toLowerCase().contains(search)))
            .toList();
      });
    } else {
      setState(() {
        searchList = dataProduk
            .where((map) => map.values.any((value) =>
                value != null &&
                value.toString().toLowerCase().contains(search)))
            .toList();
      });
    }

    log("return : " + searchList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            // decoration: BoxDecoration(
            //   color: Warna.blueBaz,
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(25),
            //   ),
            // ),
            child: TextField(
              onSubmitted: (value) {
                // searchLoader(toCamelCase(value));
                searchLoader(value);
              },
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                hintText: 'Mau beli apa?',
                prefixIcon: InkWell(
                  onTap: () {
                    Navigator.pop(context, 'done');
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Warna.blueBaz,
                    size: 25,
                  ),
                ),
                suffixIcon: Icon(
                  !_isConditionMet ? Icons.close_rounded : Icons.search_sharp,
                  color: Warna.blueBaz,
                  size: 25,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Warna.blueBaz, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Warna.blueBaz,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: AlignedGridView.count(
        itemCount: searchList.length,
        // controller: _featuredProductScrollController,
        crossAxisCount: 2,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          return productCard(
            width: 200,
            heigh: 200,
            ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetail(
                  id: searchList[index]['id'],
                  image: searchList[index]['image'],
                  productName: searchList[index]['produk'],
                  productPrice: searchList[index]['harga'],
                  priceDiscount: searchList[index]['diskon'],
                  indexProduk: searchList[index],
                );
              }));
            },
            image: searchList[index]['image'],
            productName: searchList[index]['produk'],
            productPrice: searchList[index]['harga'],
            productDiskon: searchList[index]['diskon'],
          );
        },
      ),
    );
  }
}
