import 'package:chatbot/components/chat_bubble.dart';
import 'package:chatbot/services/gemini/gemini_api.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  final String promptContext;
  const ChatPage({super.key, required this.promptContext});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool initMessage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
        // APPBAR SECTION
      AppBar(
      title: SizedBox(
        height: 40.0, // Adjust height as needed
        child: Image.asset(
          'assets/images/PngItem_5002858.png',
          fit: BoxFit.contain,
          ),
        ),
      ),
        // CHAT SECTION
        Expanded( 
          child: Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              String empty = '';
              if (chatProvider.messages.isEmpty && widget.promptContext == empty) {
                return const Center(child: Text('Start a conversation!'));
              } 
              else if (chatProvider.messages.isEmpty && widget.promptContext != empty && initMessage) {
                // Add initial message
                chatProvider.sendMessage(widget.promptContext);
                initMessage = false;
              } 

              return Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messages[index];
                      return ChatBubble(message: message);
                    },
                  ),

                  // Show typing indicator **at the bottom** when AI is responding
                  if (chatProvider.isLoading)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              colors: [
                                Colors.green.shade700,
                                Colors.lightGreen.shade600,
                                Colors.yellow.shade100
                              ],
                              strokeWidth: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
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
                  //prevent user from sending message while AI is responding
                  enabled: !Provider.of<ChatProvider>(context).isLoading,
                  minLines: 1,
                  maxLines: 6,
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
                    //scroll
                    Future.delayed(Duration(milliseconds: 300), () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                    });
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