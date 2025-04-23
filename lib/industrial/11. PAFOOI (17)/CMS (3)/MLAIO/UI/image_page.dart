import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(17)/CMS%20(3)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CMSProducts()),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Multi Line (Permanent) ALL IN ONE Monitoring + Lubrication',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Image Card Section
        Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 300,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/industrial/PFOOI/CMS/MLAIO.png', // Path to your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
