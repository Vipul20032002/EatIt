import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Util/colors.dart';
import 'BigText.dart';
import 'SmallText.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: text),
            SizedBox(height: 10),

            Row(
              children: [
                Wrap(
                  children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15,)),
                ),
                SizedBox(width: 10),
                SmallText(text: "4.5"),
                SizedBox(width: 10),
                SmallText(text: "1287 comments")
              ],
            ),
            SizedBox(height: 15),

            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.circle,color: AppColors.yellowColor,size: 20),
                    SizedBox(width: 5),
                    SmallText(text: "Normal")
                  ],
                ),
                SizedBox(width: 20),

                Row(
                  children: [
                    Icon(Icons.location_on,color: AppColors.mainColor,size: 20),
                    SizedBox(width: 5),
                    SmallText(text: "1.7km")
                  ],
                ),
                SizedBox(width: 20),

                Row(
                  children: [
                    Icon(Icons.access_time_rounded,color: AppColors.iconColor2,size: 20),
                    SizedBox(width: 5),
                    SmallText(text: "32min")
                  ],
                )
              ],
            )
          ],
        )
    );
  }
}
