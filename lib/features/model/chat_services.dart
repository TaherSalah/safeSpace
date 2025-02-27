import 'package:string_similarity/string_similarity.dart';

class ChatbotService {
  final Map<String, String> responses = {
    // English Responses
    "hello": "Hi! I'm your heart health assistant. How can I help you today?",
    "how are you": "I'm here to assist you with heart health-related queries!",
    "what is your name":
        "I'm a Heart Care Chatbot, designed to provide heart health information.",
    "bye": "Take care of your heart! Goodbye!",
    "heart attack symptoms":
        "Common symptoms of a heart attack include chest pain, shortness of breath, nausea, and dizziness. If you experience these, seek emergency help immediately!",
    "heart rate check":
        "I can help assess your heart rate. How many beats per minute (BPM) is your heart beating now?",
    "is my heart rate okay": "Tell me your BPM, and I’ll let you know!",

    // Arabic Responses
    "مرحبا": "مرحبًا! أنا مساعدك الصحي للقلب. كيف يمكنني مساعدتك اليوم؟",
    "كيف حالك": "أنا هنا لمساعدتك في الاستفسارات المتعلقة بصحة القلب!",
    "ما اسمك": "أنا روبوت صحة القلب، مصمم لتقديم معلومات عن صحة القلب.",
    "وداعًا": "اعتنِ بقلبك! إلى اللقاء!",
    "أعراض النوبة القلبية":
        "تشمل الأعراض الشائعة للنوبة القلبية: ألم في الصدر، ضيق التنفس، الغثيان، والدوخة. إذا كنت تعاني من هذه الأعراض، اطلب المساعدة الطبية فورًا!",
    "معدل ضربات القلب":
        "يمكنني مساعدتك في قياس معدل ضربات قلبك. كم عدد النبضات في الدقيقة الآن؟",
    "هل معدل ضربات قلبي طبيعي":
        "أخبرني بمعدل نبضات قلبك وسأخبرك إذا كان طبيعيًا!",
  };

  // Detect if the input language is Arabic
  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  // Get the best matching response
  String getResponse(String message) {
    String lowerMessage = message.toLowerCase();
    List<String> matchingResponses = [];

    double highestSimilarity = 0.0;
    String bestMatchKey = "";

    // Find the most similar response
    responses.forEach((key, value) {
      double similarityScore = lowerMessage.similarityTo(key);
      if (similarityScore > highestSimilarity) {
        highestSimilarity = similarityScore;
        bestMatchKey = key;
      }
    });

    // If similarity is above 60%, return the best match
    if (highestSimilarity > 0.6) {
      return responses[bestMatchKey]!;
    }

    // Check if input is a heart rate number
    if (RegExp(r'^\d+$').hasMatch(lowerMessage)) {
      int heartRate = int.parse(lowerMessage);

      if (heartRate < 60) {
        return isArabic(message)
            ? "معدل ضربات قلبك أقل من 60 نبضة في الدقيقة (بطء القلب). إذا كنت تشعر بالدوار أو التعب، يجب عليك استشارة الطبيب."
            : "Your heart rate is below 60 BPM (bradycardia). If you feel dizzy or weak, you should consult a doctor.";
      } else if (heartRate >= 60 && heartRate <= 100) {
        return isArabic(message)
            ? "معدل ضربات قلبك في النطاق الطبيعي (60-100 نبضة في الدقيقة). استمر في المراقبة وابقَ بصحة جيدة!"
            : "Your heart rate is in the normal range (60-100 BPM). Keep monitoring and stay healthy!";
      } else {
        return isArabic(message)
            ? "معدل ضربات قلبك أعلى من 100 نبضة في الدقيقة (تسارع القلب). إذا لم تكن تمارس الرياضة أو تشعر بالتوتر، استشر الطبيب."
            : "Your heart rate is above 100 BPM (tachycardia). If you're not exercising or stressed, consider checking with a doctor.";
      }
    }

    // Default response if no match found
    return isArabic(message)
        ? "عذرًا، لم أفهم سؤالك جيدًا. جرب استخدام كلمات مثل: \"معدل ضربات القلب\" أو \"أعراض النوبة القلبية\"."
        : "Sorry, I didn't quite understand that. Try using words like 'heart rate' or 'heart attack symptoms'.";
  }
}