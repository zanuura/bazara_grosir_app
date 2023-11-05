import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';
import 'package:product_groceries/widgets/custom_text.dart';

Widget productCard({
  String image = '',
  String? productName,
  int? productPrice,
  int? productDiskon,
  double? width,
  double? heigh,
  Function()? ontap,
}) {
  return InkWell(
    onTap: ontap,
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
                width: width != null ? width : 120,
                height: heigh != null ? heigh : 120,
                child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
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
                    productName.toString(),
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
                    currText(text: productPrice.toString()),
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
                    currText(text: productDiskon.toString()),
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
  );
}
