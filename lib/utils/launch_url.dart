import 'package:url_launcher/url_launcher.dart';

launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
