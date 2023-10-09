import 'dart:convert';
import 'package:http/http.dart' as http;
class PushNotifications {

  Future<bool> send({
    String title = 'QrToLogin',
    String? deviceToken,
    String? token,
  }) async {
    const String url = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> data = {
      'notification': {
        'title': title,
      },
      'priority': 'high',
      'data': {
        'status': 'done',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'token': token
      },
      'to': '$deviceToken',
      'message': {
        'token': '$deviceToken'
      }
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "",
    };

    final result = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers,
    );

    return result.statusCode == 200;
  }

  Future<bool> sendToTopic(String id, {
    String topic = 'all',
    String title = 'QrToLogin',
    String token = '',
  }) async {
    const String url = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> data = {
      'notification': {
        'title': title,
      },
      'priority': 'high',
      'data': {
        'id': id,
        'status': 'done',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'token': token,
      },
      'topic': topic,
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "",
    };

    final result = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers,
    );

    return result.statusCode == 200;
  }
}


