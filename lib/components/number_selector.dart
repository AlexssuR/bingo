import 'package:flutter/material.dart';

class SelectNumberWidget extends StatefulWidget {
  final TextEditingController numberController;
  final List<int> numberList;
  final VoidCallback addNumber;
  final VoidCallback deleteNumber;
  final VoidCallback deleteAllNumbers;

  SelectNumberWidget({
    super.key,
    required this.numberController,
    required this.numberList,
    required this.addNumber,
    required this.deleteNumber,
    required this.deleteAllNumbers,
  });

  @override
  _SelectNumberWidgetState createState() => _SelectNumberWidgetState();
}

class _SelectNumberWidgetState extends State<SelectNumberWidget> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: widget.numberController,
              keyboardType: TextInputType.number,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Enter a number',
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.addNumber();
                  focusNode.requestFocus(); // Keep the focus on the TextField
                }
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.addNumber();
                    focusNode.requestFocus(); // Keep the focus on the TextField
                  },
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: widget.deleteNumber,
                  child: Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: widget.deleteAllNumbers,
                  child: Text('Delete All'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Numbers: ${widget.numberList.join("  ")}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
