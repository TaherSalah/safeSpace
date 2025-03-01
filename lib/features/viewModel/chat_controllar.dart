import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
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

  // ✅ Speech-to-Text (Voice Input)
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  bool hasSpeechPermission = false; // ✅ Track permission status

  // ✅ Text-to-Speech (GPT Voice Response)
  final FlutterTts _tts = FlutterTts();

  // ✅ Initialize TTS & Speech Recognition
  Future<void> initServices() async {
    _tts.setLanguage("en-US");
    _tts.setPitch(1.0);
    _tts.setSpeechRate(0.5);

    hasSpeechPermission = await _speech.initialize(
      onStatus: (status) => print("Speech Status: $status"),
      onError: (error) => print("Speech Error: $error"),
    );
  }

  // ✅ Function to Start Listening (Voice Input)
  void startListening() async {
    if (!hasSpeechPermission) {
      print("Speech recognition permission denied!");
      return;
    }

    isListening = true;
    _speech.listen(
      onResult: (result) {
        controller.text = result.recognizedWords; // ✅ Update input field
      },
    );
    setState(() {});
  }

  // ✅ Function to Stop Listening
  void stopListening() {
    _speech.stop();
    isListening = false;
    setState(() {});
  }

  // ✅ Send Message (Handles Text & Speech Input)
  void sendMessage() async {
    if (controller.text.isEmpty) return;

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

    // ✅ Speak GPT's Response (Text-to-Speech)
    _tts.speak(botResponse);
  }

  // ✅ Scroll to Bottom
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
}

class GPTService {
  final OpenAI _openAI = OpenAI.instance.build(
    token:"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",
        // "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", // ✅ Replace with your OpenAI API key
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),
    enableLog: true, // ✅ Enable logging for debugging
  );

  Future<String> getGPTResponse(String userInput) async {
    final request = ChatCompleteText(
      model:
          GptTurboChatModel(), // ✅ Use GPT-3.5 Turbo or Gpt4ChatModel() for GPT-4
      messages: [
        {
          "role": "system",
          "content": "You are a helpful heart health chatbot."
        },
        {"role": "user", "content": userInput},
      ],
      maxToken: 3000, // ✅ Limit response length
    );

    try {
      final response = await _openAI.onChatCompletion(request: request);
      return response?.choices.first.message?.content ??
          "Sorry, I couldn't process your request.";
    } catch (e) {
      print("GPT API Error: $e"); // ✅ Print API errors for debugging
      return "Sorry, there was an issue processing your request.";
    }
  }
}
