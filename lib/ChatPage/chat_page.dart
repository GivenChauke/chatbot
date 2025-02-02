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
                 if (!chatProvider.isInitialized)  {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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

                    //return message
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.timestamp.toString()),
                      leading: message.isUser
                          ? const Icon(Icons.person)
                          : const Icon(Icons.computer),
                    );
                  },
                );
              },
            ),
          ),
          //USER INPUT SECTION
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if(_controller.text.isNotEmpty) {
                  //send message
                  final chatProvider = Provider.of<ChatProvider>(context, listen: false);
                  chatProvider.sendMessage(_controller.text);
                  _controller.clear();
                  }
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      )
    );
  }
}