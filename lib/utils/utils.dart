import 'package:url_launcher/url_launcher.dart';

Future<bool> launchURL(String url) async {
  if (await canLaunch(url)) {
    return await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<bool> launchPhone(String phoneNumber) async {
  final phoneUrl = "tel:$phoneNumber";
  if (await canLaunch(phoneUrl)) {
    return await launch(phoneUrl);
  } else {
    throw 'Could not launch $phoneUrl';
  }
}

Future<bool> launchEmail(String email) async {
  final emailUrl = "mailto:$email";
  if (await canLaunch(emailUrl)) {
    return await launch(emailUrl);
  } else {
    throw 'Could not launch $emailUrl';
  }
}
