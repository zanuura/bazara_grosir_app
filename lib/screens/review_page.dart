import 'package:flutter/material.dart';
import 'package:product_groceries/my_theme.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage(
      {required this.productImage,
      required this.productName,
      required this.productPrice});
  var productImage;
  var productName;
  var productPrice;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Warna.blueBaz),
        title: Text(
          'Ulasan',
          style: TextStyle(color: Warna.blueBaz),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 18,
                ),
                SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.productImage,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.productName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Rp.' + widget.productPrice.toString(),
                      style: TextStyle(
                        color: Warna.goldHalfBaz,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return reviewCard(
                  username: 'username',
                  text: 'Disini test ulasan akan muncul',
                  image: '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewCard({
    required String username,
    required String text,
    required String image,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Warna.blueHalfBaz,
            // backgroundImage: , 'assets/baz_icons/baz_akun.png'
          ),
          title: Text(
            username,
            style: TextStyle(color: Warna.blueBaz),
          ),
          subtitle: Text(text),
          trailing: InkWell(
            onTap: () {},
            child: Icon(
              Icons.more_vert_rounded,
              size: 25,
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Warna.blueHalfBaz,
                    borderRadius: BorderRadius.circular(5)),
              );
            },
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 5,
          thickness: 8,
          color: Colors.grey[200],
        )
      ],
    );
  }
}
