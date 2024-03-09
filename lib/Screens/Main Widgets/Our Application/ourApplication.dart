import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:url_launcher/url_launcher.dart';

class OurApplication extends StatefulWidget {
  const OurApplication({super.key});

  @override
  State<OurApplication> createState() => _OurApplicationState();
}

class _OurApplicationState extends State<OurApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Our Application",
      ),
      body: SingleChildScrollView(
        child: Column(
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
            const Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, top: 10.0, right: 10.0),
              child: CustomText(
                "LOYADHAM SATSANG APP is a modern technological tool, inspired by Sadguru Shashtri Shri GhanshyamPrakashDasji Swami to lead the life of aspirant towards spiritual upliftment, to have darshan of Lord Swaminarayan and his Saints and to live a progressive life in the Satsang",
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
                color: Colors.black,
              ),
            ),
            const Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, top: 10.0, right: 10.0),
              child: CustomText(
                "LOYADHAM SATSANG APP is a modern digital and spiritual gateway incorporating the divine collections of engaging, inspirational, and divine Katha (spiritual discourses), enchanting Kirtans (devotional songs), mesmerizing Dhun (spiritual chant), audiobooks, and various collections of Daily Darshan (images of Supreme Lord Swaminarayan), Shibir-Mahotsav, , Cultural Programs, Awareness, Hindola-Abhishek and other digital media of the Swaminarayan sect.",
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
                          "https://play.google.com/store/apps/details?id=com.phoenix.loyadhamsatsang&hl=en_IN&gl=US&pli=1"));
                    },
                    icon: Icon(Icons.android),
                    label: Text("DOWNLOAD")),
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(Uri.parse(
                          "https://apps.apple.com/in/app/loyadham-satsang/id1026670160"));
                    },
                    icon: Icon(Icons.apple),
                    label: Text("DOWNLOAD")),
              ],
            ),
            Divider(),
            SizedBox(
              height: 5.0,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10.0),
              child: CustomText(
                "Loyadham Jap Yagna".toUpperCase(),
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, top: 10.0, right: 10.0),
              child: CustomText(
                "Chanting the name of God, also known as Japa in Sanskrit, is a vital practice for those who wish to infuse their lives with the remembrance of God. However, it is very difficult to balance one’s spiritual life with their daily activities. Keeping that in mind, with the grace of Lord Shree Swaminarayan and H.D.H Shastri Shri Ghanshyamprakashdasji Swami, Shree Swaminarayan Mandir Loyadham has developed an application that will allow users to chant Lord's name on a digital platform.",
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
                color: Colors.black,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(Uri.parse(
                          "https://play.google.com/store/apps/details?id=app.loyadhamjapyagna.phoenix"));
                    },
                    icon: Icon(Icons.android),
                    label: Text("DOWNLOAD")),
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(Uri.parse(
                          "https://apps.apple.com/in/app/loyadham-jap-yagna/id1592281583"));
                    },
                    icon: Icon(Icons.apple),
                    label: Text("DOWNLOAD")),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
