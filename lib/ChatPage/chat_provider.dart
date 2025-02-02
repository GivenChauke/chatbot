import 'package:chatbot/components/message.dart';
import 'package:chatbot/global_variables.dart';
import 'package:chatbot/services/gemini/gemini_api.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final GeminiService _apiService;

bool _isInitialized = false;

    ChatProvider(String apiKey) : _apiService = GeminiService(apiKey);

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    // Perform any necessary initialization here
    await Future.delayed(Duration(seconds: 5)); // Simulate initialization delay
    _isInitialized = true;
    notifyListeners();
  }
  //messages and loading
  List<Message> messages = [];
  bool isLoading = false;

  //getters
  List<Message> get getMessages => messages;
  bool get getIsLoading => isLoading;

  //send message
  Future<void> sendMessage(String content) async {
    //prevent empty messages
    if (content.isEmpty) return;

    //user message
    final userMessage = Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    //add user message to messages
    messages.add(userMessage);
    //update UI
    notifyListeners();

    //start loading
    isLoading = true;

    //update UI
    notifyListeners();


// Send message to API and get response
try {
  final response = await _apiService.generateText(content);
  print(response);

  // Parse the response
  final candidates = response['candidates'];
  if (candidates != null && candidates.isNotEmpty) {
    final content = candidates[0]['content'];
    if (content != null) {
      final parts = content['parts'];
      if (parts != null && parts.isNotEmpty) {
        final text = parts[0]['text'];
        if (text != null) {
          final botMessage = Message(
            content: text,
            isUser: false,
            timestamp: DateTime.now(),
          );

          // Add bot message to messages
          messages.add(botMessage);
        }
      }
    }
  }
} catch (e) {
  print(e);
  // Add error message
  final errorMessage = Message(
    content: 'Sorry, I encountered an issue. Please try again.',
    isUser: false,
    timestamp: DateTime.now(),
  );
  // Add error message to messages
  messages.add(errorMessage);
} finally {
  // Stop loading
  isLoading = false;
  // Update UI
  notifyListeners();
}
  }
}
//response
/**{candidates: [{content: {parts: [{text: Hi there! How can I help you today?
}], role: model}, finishReason: STOP, avgLogprobs: -0.0003608061762695963}], usageMetadata:
{promptTokenCount: 1, candidatesTokenCount: 11, totalTokenCount: 12, promptTokensDetails: [{modality: TEXT,
tokenCount: 1}], candidatesTokensDetails: [{modality: TEXT, tokenCount: 11}]}, modelVersion:
gemini-1.5-flash}
NoSuchMethodError: '[]'
Dynamic call of null.
Receiver: null
Arguments: [0] */