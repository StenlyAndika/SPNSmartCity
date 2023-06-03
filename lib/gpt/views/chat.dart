import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:smartcity/constants/api_gpt.dart';

import '../../widgets/header.dart';
import '../models/model_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const nameRoute = '/chatgpt';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _message = [];
  bool _isLoading = false;

  void _handleSubmitted(String text) async {
    if (text != '') {
      FocusManager.instance.primaryFocus?.unfocus();
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
      Uri.parse(ApiGPT.url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiGPT.key}',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
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
              subtitle: "Powered by OpenAI GPT 3.5 Turbo Model"),
          Container(
            padding: const EdgeInsets.only(top: 35),
            height: MediaQuery.of(context).size.height * 0.865,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                  decoration: const BoxDecoration(color: Color(0xFFEDECF2)),
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
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: message.isAi ? Colors.white : const Color(0xFFEDECF2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          message.isAi
              ? Image.asset(
                  'assets/gpt/chat_logo.png',
                  height: 30,
                  width: 30,
                )
              : Image.asset(
                  'assets/gpt/person.png',
                  height: 30,
                  width: 30,
                ),
          Expanded(
            child: Text(
              message.text,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Kirim pesan',
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
