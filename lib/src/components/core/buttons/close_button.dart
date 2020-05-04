import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shots/src/router/router.gr.dart';
import 'package:shots/src/services/sound_service.dart';
import 'package:shots/src/styles/text_styles.dart';
import 'package:shots/src/styles/values.dart';

class AppCloseButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  AppCloseButton({this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        padding: EdgeInsets.all(Values.buttonVerticalPadding),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.3),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(
          // by default, show the cross icon unless another one is specified
          iconData ?? FontAwesomeIcons.times,
          color: color ?? Colors.red,
          size: TextStyles.button.fontSize,
        ),
      ),
      onTap: () {
        // play pop button sound
        SoundService.primaryPop();

        // go to previous page
        ExtendedNavigator.ofRouter<Router>().pop();
      },
    );
  }
}
