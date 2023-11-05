import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/screens/data_dummy.dart';

class TerlarisProductPage extends StatefulWidget {
  const TerlarisProductPage({super.key});

  @override
  State<TerlarisProductPage> createState() => _TerlarisProductPageState();
}

class _TerlarisProductPageState extends State<TerlarisProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.blueBaz,
        title: Text('Produk Terlaris'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             GridView.builder(
                         itemCount: dataProduk.length,
                         // controller: _featuredProductScrollController,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           // childAspectRatio: (120 / 220),
                           // crossAxisCount: (orientation == Orientation.portrait) ? 3 : 3,
                           crossAxisCount: 3,
                           crossAxisSpacing: 0,
                           mainAxisSpacing: 0,
                           childAspectRatio: (MediaQuery.of(context).size.height * 0.00072),
                           // childAspectRatio: 0.600,
                         ),
                         padding: EdgeInsets.all(8),
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemBuilder: (context, index) {
                          return  Card(
                             margin: EdgeInsets.all(5.0),
                             child: InkWell(
                       onTap: () {
                         // Navigator.push(context, MaterialPageRoute(builder: (context) {
                         //   return ProductDetails(
                         //     id: widget.id,
                         //   );
                         // }));
                       },
                       child: Container(
                         // height: 300,
                         child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisSize: MainAxisSize.max,
                             children: <Widget>[
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        // side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          // width: double.infinity,
                          // height: 100,
                          // height: (( MediaQuery.of(context).size.width - 100 ) / 2),
                          // height: ((MediaQuery.of(context).size.width - 75) / 2),
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(dataProduk[index]['image'],
                                //placeholder: 'assets/placeholder.png',
                                // Image: "", //ini gambar nya
                                fit: BoxFit.cover,
                              ))),
                    ),
                    Container(
                      // height: 180,
                      // padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Text(
                              dataProduk[index]['produk'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.font_grey,
                                  fontSize: 12,
                                  height: 1.2,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Text(
                              dataProduk[index]['harga'],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(0xff7789A4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                         Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    dataProduk[index]['diskon'],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: MyTheme.medium_grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                           
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                            child: Text(
                              'Bandung,Kota',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.font_grey,
                                  fontSize: 10,
                                  // height: 1.2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                             ]),
                       ),
                      
                     ),
                           );
                         },
                       ),
          ],
        ),
      ),
    );
  }
}