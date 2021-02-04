import 'package:url_launcher/url_launcher.dart';

Future<bool> launchURL(String url) async {
  if (await canLaunch(url)) {
    return launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<bool> launchPdf(String url) async {
  final queryParameters = {'url': url, 'embedded': 'true'};
  final uri = Uri.https('docs.google.com', 'gview', queryParameters);

  return launchURL(uri.toString());
}

Future<bool> launchPhone(String phoneNumber) async {
  final phoneUrl = 'tel:$phoneNumber';
  if (await canLaunch(phoneUrl)) {
    return launch(phoneUrl);
  } else {
    throw 'Could not launch $phoneUrl';
  }
}

Future<bool> launchEmail(String email) async {
  final emailUrl = 'mailto:$email';
  if (await canLaunch(emailUrl)) {
    return launch(emailUrl);
  } else {
    throw 'Could not launch $emailUrl';
  }
}
