import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Recommended to use a prefix
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  // ChatUser for the current user
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'AYO');
  // ChatUser for the AI (Diva) - IMPORTANT: Use a different ID
  final ChatUser _divaUser = ChatUser(id: '2', firstName: 'Diva');

  final List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  // Method to fetch AI response and add it to messages list
  Future<void> _fetchAndAddDivaResponse(String inputText) async {
    // --- Call API to get Diva's response ---
    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":
              "Bearer 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", // Replace with your actual token if this is a placeholder
        },
        body: jsonEncode({
          "model":
              "deepseek/deepseek-r1:free", // Ensure this model is available
          "messages": [
            {
              "content":
                  "You are a helpful assistant. Please format your responses using Markdown where appropriate (e.g., for lists, bolding, italics, or code snippets).",
              "role": "system",
            },
            {"content": inputText, "role": "user"},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final divaResponseText = jsonData['choices'][0]['message']['content'];

        // Create Diva's message
        final divaChatMessage = ChatMessage(
          user: _divaUser, // Use the _divaUser
          createdAt: DateTime.now(),
          text: divaResponseText,
        );

        // Add Diva's message to the list and update UI
        if (mounted) {
          // Check if the widget is still in the tree
          setState(() {
            _messages.insert(0, divaChatMessage);
          });
        }
      } else {
        // Handle API error by showing an error message in chat
        final errorChatMessage = ChatMessage(
          user: _divaUser,
          createdAt: DateTime.now(),
          text:
              "Sorry, I couldn't get a response. Status: ${response.statusCode}",
        );
        if (mounted) {
          setState(() {
            _messages.insert(0, errorChatMessage);
            _typingUsers = [];
          });
        }
        // You might want to log the full error: print('API Error: ${response.body}');
      }
    } catch (e) {
      // Handle network or other errors by showing an error message in chat
      final exceptionChatMessage = ChatMessage(
        user: _divaUser,
        createdAt: DateTime.now(),
        text: "Sorry, something went wrong: ${e.toString()}",
      );
      if (mounted) {
        setState(() {
          _messages.insert(0, exceptionChatMessage);
        });
      }
      // print('Exception: $e');
    } finally {
      if (mounted) {
        setState(() => _typingUsers = []);
      }
    }
  }

  // Method to handle sending message from the custom input field
  Future<void> _handleSendPressed() async {
    final inputText = _textEditingController.text.trim();
    if (inputText.isEmpty) {
      return; // Don't send empty messages
    }

    // Create user's message
    final userChatMessage = ChatMessage(
      user: _currentUser,
      createdAt: DateTime.now(),
      text: inputText,
    );

    // Add user's message to the list and update UI
    if (mounted) {
      setState(() {
        _messages.insert(0, userChatMessage);
        _typingUsers = [_divaUser];
      });
    }

    _textEditingController.clear(); // Clear the input field

    // Fetch and add Diva's response
    await _fetchAndAddDivaResponse(inputText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 70, 136),
        title: const Text('Diva AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: DashChat(
              currentUser: _currentUser,

              onSend: (ChatMessage message) async {
                if (mounted) {
                  setState(() {
                    _messages.insert(0, message);
                  });
                }
                await _fetchAndAddDivaResponse(message.text);
              },
              typingUsers: _typingUsers,
              messages: _messages,
              messageOptions: const MessageOptions(
                showCurrentUserAvatar: true,
                showOtherUsersAvatar: true,
              ),

              inputOptions: InputOptions(
                inputDisabled: true, // Disables the input field
                sendButtonBuilder:
                    (send) => const SizedBox.shrink(), // Hides the send button
                inputToolbarStyle: const BoxDecoration(
                  // Hides the toolbar itself
                  color: Colors.transparent,
                  border: Border.fromBorderSide(BorderSide.none),
                ),
                inputToolbarPadding: EdgeInsets.zero,
                inputToolbarMargin: EdgeInsets.zero,
                inputDecoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          // Your custom input field
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a message...',
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        maxLines: null,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted:
                            (_) =>
                                _handleSendPressed(), // Optionally send on keyboard submit
                      ),
                    ),
                    IconButton(
                      onPressed: _handleSendPressed,
                      icon: const Icon(Icons.send_rounded),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
