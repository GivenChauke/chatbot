import 'package:chatbot/components/chat_bubble.dart';
import 'package:chatbot/services/gemini/gemini_api.dart';
import 'chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          //TOP SECTION: Chat Messages
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.messages.isEmpty) {
                  return const Center(
                    child: Text('Start a conversation!'),
                  );
                }

                //chat messages
                return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    //get each message
                    final message = chatProvider.messages[index];

                    //return ChatBubble
                    return ChatBubble(message: message);
                  },
                );
              },
            ),
          ),
        // USER INPUT SECTION
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () => _controller.clear(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
                    chatProvider.sendMessage(_controller.text);
                    _controller.clear();
                  }
                },
                backgroundColor: Colors.green.shade600,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
        ],
        ),
    );
  }
}