import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String img_path;
  const NoDataPage({Key? key,required this.text,this.img_path = "assets/images/empty-cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              img_path,
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width*0.5,
            ),
            height: 150,
            margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25,bottom: 5),
          ),
          //SizedBox(height: MediaQuery.of(context).size.height*0.005),
          Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height*0.0250,
                color: Theme.of(context).disabledColor
              ),
            ),
          )
        ],
      ),
    );

  }
}
