import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<bool> sendMail(Email email) async {
  try {
    await FlutterEmailSender.send(email);
    return true;
  } catch (e) {
    return false;
  }
}
