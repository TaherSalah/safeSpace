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

  void startListening() async {
    if (!hasSpeechPermission) {
      print("Speech recognition permission denied!");
      return;
    }

    isListening = true;
    _speech.listen(
      localeId: "en", // دعم اللغات المختلفة
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
    setState(() {
      messages.add({"role": "user", "content": userMessage});
      controller.clear();
      isLoading = true;
      scrollToBottom();
    });

    String botResponse = await _gptService.getGPTResponse(userMessage);
    setState(() {
      messages.add({"role": "bot", "content": botResponse});
      isLoading = false;
      scrollToBottom();
    });
    _tts.setLanguage("en");
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
    token: "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", // استبدل بمفتاح API الخاص بك
    baseOption: HttpSetup(receiveTimeout: Duration(seconds: 10)),
    enableLog: true,
  );

  Future<String> getGPTResponse(String userInput) async {
    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: [
        {"role": "system", "content":"You are a heart health chatbot."},
        {"role": "user", "content": userInput},
      ],
      maxToken: 3000,
    );

    try {
      final response = await _openAI.onChatCompletion(request: request);
      return response?.choices.first.message?.content ?? "Error processing request.";
    } catch (e) {
      print("GPT API Error: $e");
      return "There was an issue processing your request.";
    }
  }
}
