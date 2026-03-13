/// Notification service skeleton.
/// Integrate with Firebase Cloud Messaging (FCM) by replacing stubs.
class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance =
      NotificationService._internal();
  factory NotificationService() => _instance;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    // TODO: Initialize FCM
    // await Firebase.initializeApp();
    // final messaging = FirebaseMessaging.instance;
    // await messaging.requestPermission();
    _initialized = true;
  }

  Future<String?> getToken() async {
    // TODO: return await FirebaseMessaging.instance.getToken();
    return null;
  }

  Future<void> subscribeTopic(String topic) async {
    // TODO: await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unsubscribeTopic(String topic) async {
    // TODO: await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}
