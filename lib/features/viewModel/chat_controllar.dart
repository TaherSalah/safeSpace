import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatController extends ControllerMVC {
  static ChatController? _this;

  factory ChatController([StateMVC? state]) {
    _this ??= ChatController._(state);
    return _this!;
  }

  ChatController._(super.state);
  final GPTService _gptService = GPTService();
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<Map<String, String>> messages = [];
  bool isLoading = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  bool hasSpeechPermission = false;
  final FlutterTts _tts = FlutterTts();

  Future<void> initServices() async {
    _tts.setLanguage("en");
    _tts.setPitch(1.0);
    _tts.setSpeechRate(0.5);

    hasSpeechPermission = await _speech.initialize(
      onStatus: (status) => print("Speech Status: $status"),
      onError: (error) => print("Speech Error: $error"),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tts.stop();
  }

  void startListening() async {
    if (!hasSpeechPermission) {
      print("Speech recognition permission denied!");
      return;
    }

    isListening = true;
    _speech.listen(
      localeId: "en",
      onResult: (result) {
        controller.text = result.recognizedWords;
        if (result.finalResult) {
          stopListening();
          sendMessage();
        }
      },
    );
    setState(() {});
  }

  void stopListening() {
    _speech.stop();
    isListening = false;
    setState(() {});
  }

  void sendMessage() async {
    if (controller.text.isEmpty) return;
    await _tts.stop();

    String userMessage = controller.text;
    controller.clear();
    isLoading = true;

    String botResponse = await _gptService.getGPTResponse(userMessage);

    isLoading = false;

    _tts.speak(botResponse);
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void changeLanguage(String languageCode) {
    languageCode = "en";
    _tts.setLanguage(languageCode);
    print("Language changed to: $languageCode");
  }
}

class GPTService {
  final OpenAI _openAI = OpenAI.instance.build(
    token: "add  a new token ",
    baseOption: HttpSetup(receiveTimeout: Duration(seconds: 10)),
    enableLog: true,
  );

  Future<String> getGPTResponse(String userInput) async {
    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: [
        {"role": "system", "content": "You are a heart health chat bot."},
        {"role": "user", "content": userInput},
      ],
      maxToken: 200,
    );

    try {
      final response = await _openAI.onChatCompletion(request: request);
      return response?.choices.first.message?.content ??
          "Error processing request.";
    } catch (e) {
      print("GPT API Error: $e");
      return "There was an issue processing your request.";
    }
  }
}
