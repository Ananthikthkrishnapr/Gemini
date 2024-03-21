import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:gemini_1/models/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  static const key = 'AIzaSyCZDt7_XC3WkOv0JU5ZGvWZuGCZ2xCw58Y';
  final model = GenerativeModel(model: 'gemini-pro', apiKey: key);
  TextEditingController contro = TextEditingController();
  List<Messages> messageList = [];
  Future<void> sendMessage() async {
    messageList.add(
        Messages(isUser: true, message: contro.text, date: DateTime.now()));
    final content = [Content.text(contro.text)];
    final response = await model.generateContent(content);
    messageList.add(Messages(
        isUser: false, message: response.text ?? "", date: DateTime.now()));
    contro.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Gemini-AI")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: messageList.length,
            itemBuilder: (context, index) {
             return BubbleNormal(text: messageList[index].message,isSender: messageList[index].isUser,);
            },
          )),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 39,
                  child: TextField(
                      controller: contro,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Text Messages",hintStyle: TextStyle(fontSize: 15))),
                ),
              ),
              SizedBox(
                  height: 43,
                  child:
                      ElevatedButton(onPressed: () {
                        sendMessage();
                      }, child: Icon(Icons.send)))
            ],
          ),
        ],
      ),
    );
  }
}
