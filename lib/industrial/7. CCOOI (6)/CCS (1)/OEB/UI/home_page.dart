import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/7.%20CCOOI%20(6)/CCS%20(1)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CCSProducts()),
        const Padding(
          padding: EdgeInsets.fromLTRB(
              15.0, 30.0, 15.0, 20.0), // Adjusted top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Overspray Eliminator Brush:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25), // Space between the title and description
              Text(// this is what it is supposed to say to leave alone -Addison 
                'The Overspray Eliminator Brush is also known as the part saver brush because it prevents contamination of parts by lubricant overspray. '
                'The part saver brush assembly mounts on the conveyor at the location of the lubricator.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
