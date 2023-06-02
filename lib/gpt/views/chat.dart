import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../../widgets/header.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const nameRoute = '/chatgpt';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class ChatMessage {
  final String text;
  final bool isAi;

  ChatMessage({required this.text, required this.isAi});
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _message = [];
  bool _isLoading = false;

  void _handleSubmitted(String text) async {
    if (text != '') {
      _textController.clear();
      ChatMessage message = ChatMessage(text: text, isAi: false);
      setState(() {
        _message.insert(0, message);
      });

      String aiResponse = await _getAIResponse(text);
      ChatMessage aiMessage = ChatMessage(text: aiResponse, isAi: true);
      setState(() {
        _message.insert(0, aiMessage);
      });
    }
  }

  Future<String> _getAIResponse(String userMsg) async {
    _isLoading = true;
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo-0301",
        "messages": [
          {"role": "user", "content": userMsg}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final aiResponse = utf8.decode(responseData['choices'][0]['message']
              ['content']
          .toString()
          .codeUnits);
      _isLoading = false;
      return aiResponse;
    } else {
      _isLoading = false;
      return 'Terjadi kesalahan. mohon coba lagi nanti.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 65, 180),
      body: ListView(
        children: [
          const Header(
              title: 'ChatGPT',
              subtitle: "AI Chatbot yang ditenagai oleh OpenAI"),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.87,
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    reverse: true,
                    itemCount: _message.length,
                    itemBuilder: (_, int index) => _buildChat(_message[index]),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 3, 65, 180)),
                  child: _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: _textComposer(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChat(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: message.isAi
          ? const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0)
          : const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: message.isAi ? const Color(0xFF343541) : const Color(0xFF444654),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        message.text,
        style: const TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );
  }

  Widget _textComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Tanya GPT',
                hintStyle: const TextStyle(color: Colors.black),
              ),
              controller: _textController,
              onSubmitted: (value) => _handleSubmitted(_textController.text),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: const Color.fromARGB(255, 3, 65, 180),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
