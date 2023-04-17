import 'package:eatit/Util/colors.dart';
import 'package:eatit/Widgets/SmallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key,required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 200;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }
    else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,size: 16,color: AppColors.paraColor,height: 1.8):Column(
        children: [
          SmallText(text:hiddenText?(firstHalf + '...'):(firstHalf + secondHalf),
          size: 16,
          color: AppColors.paraColor,
          height: 1.8,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },

            child: Row(
              children: [
                SmallText(text: hiddenText?"Show more":"Show less",color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down
                    :Icons.arrow_drop_up,color: AppColors.mainColor)
              ],
            ),
          )
        ],
      ),
    );
  }
}
