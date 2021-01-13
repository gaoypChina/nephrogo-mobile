import 'package:url_launcher/url_launcher.dart';

Future<bool> launchURL(String url) async {
  if (await canLaunch(url)) {
    return await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
