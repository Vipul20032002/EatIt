import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  FontWeight weight;
  TextOverflow textOverflow;
  BigText({Key? key , this.color = const Color(0XFF332d2b),
    required this.text,
    this.size = 20,
    this.weight = FontWeight.w600,
  this.textOverflow = TextOverflow.ellipsis,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: GoogleFonts.roboto(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
