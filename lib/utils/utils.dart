import 'package:url_launcher/url_launcher.dart';

Future<bool> launchURL(String url) async {
  if (await canLaunch(url)) {
    return launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<bool> launchPdf(String url) {
  final queryParameters = {'url': url, 'embedded': 'true'};
  final uri = Uri.https('docs.google.com', 'gview', queryParameters);

  return launchURL(uri.toString());
}

Future<bool> launchPhone(String phoneNumber) {
  final phoneUrl = 'tel:$phoneNumber';

  return launchURL(phoneUrl);
}

Future<bool> launchEmail(String email) {
  final emailUrl = 'mailto:$email';

  return launchURL(emailUrl);
}
