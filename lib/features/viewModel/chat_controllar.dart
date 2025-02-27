import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/features/model/chat_services.dart';

class ChatController extends ControllerMVC {
  factory ChatController([StateMVC? state]) =>
      _this ??= ChatController._(state);
  ChatController._(super.state);

  static ChatController? _this;

  final List<Map<String, String>> messages = [];
  final ChatbotService chatbotService = ChatbotService();

  void sendMessage(String message) {
    messages.add({"user": message});
    String botResponse = chatbotService.getResponse(message);
    messages.add({"bot": botResponse});
    setState(() {});
  }
}
