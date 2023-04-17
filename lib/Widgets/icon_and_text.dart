import 'package:eatit/Widgets/SmallText.dart';
import 'package:flutter/cupertino.dart';

class icon_and_text extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  const icon_and_text({Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor),
        SizedBox(width: 10),
        SmallText(text: text, color: color,)
      ],
    );
  }
}

