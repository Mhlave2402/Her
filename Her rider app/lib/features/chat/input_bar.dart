import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  final Function(String) onSendMessage;

  const InputBar({Key? key, required this.onSendMessage}) : super(key: key);

  @override
  _InputBarState createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    widget.onSendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed: _controller.text.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
