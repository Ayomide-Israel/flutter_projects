import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'AYO');
  final ChatUser _divaUser = ChatUser(id: '2', firstName: 'Diva');

  final List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  Future<void> _fetchAndAddDivaResponse(String inputText) async {
    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":
              "Bearer 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",
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-r1:free",
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
        final divaChatMessage = ChatMessage(
          user: _divaUser,
          createdAt: DateTime.now(),
          text: divaResponseText,
        );
        if (mounted) {
          setState(() {
            _messages.insert(0, divaChatMessage);
          });
        }
      } else {
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
      }
    } catch (e) {
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
    } finally {
      if (mounted) {
        setState(() => _typingUsers = []);
      }
    }
  }

  Future<void> _handleSendPressed() async {
    final inputText = _textEditingController.text.trim();
    if (inputText.isEmpty) {
      return;
    }
    final userChatMessage = ChatMessage(
      user: _currentUser,
      createdAt: DateTime.now(),
      text: inputText,
    );
    if (mounted) {
      setState(() {
        _messages.insert(0, userChatMessage);
        _typingUsers = [_divaUser];
      });
    }

    _textEditingController.clear();
    await _fetchAndAddDivaResponse(inputText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
                inputDisabled: true,
                sendButtonBuilder: (send) => const SizedBox.shrink(),
                inputToolbarStyle: const BoxDecoration(
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
                        onSubmitted: (_) => _handleSendPressed(),
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
