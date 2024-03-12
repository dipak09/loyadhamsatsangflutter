import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loyadhamsatsang/Controllers/ourApplication_Controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:url_launcher/url_launcher.dart';

class OurApplication extends StatefulWidget {
  const OurApplication({super.key});

  @override
  State<OurApplication> createState() => _OurApplicationState();
}

class _OurApplicationState extends State<OurApplication> {
  var OurApplication = Get.put(OurApplicationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Our Application",
      ),
      body: ListView.builder(
        itemCount: OurApplication.list.length,
        itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10.0),
              child: CustomText(
                "LOYADHAM SATSANG APP",
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
             Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, top: 10.0, right: 10.0),
              child: CustomText(
                OurApplication.list[index].description.toString(),
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
                color: Colors.black,
              ),
            ),
           
            SizedBox(
              height: 10.0,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(Uri.parse(
                          OurApplication.list[index].androidLink.toString(), ));
                    },
                    icon: Icon(Icons.android),
                    label: Text("DOWNLOAD")),
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(Uri.parse(
                          OurApplication.list[index].iosLink.toString() ));
                    },
                    icon: Icon(Icons.apple),
                    label: Text("DOWNLOAD")),
              ],
            ),
            
          ],
        );
      }),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
