import 'package:flutter/material.dart';

class SelectNumberWidget extends StatelessWidget {
  final TextEditingController numberController;
  final List<int> numberList;
  final VoidCallback addNumber;
  final VoidCallback deleteNumber;

  SelectNumberWidget({
    super.key,
    required this.numberController,
    required this.numberList,
    required this.addNumber,
    required this.deleteNumber,
  });

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
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter a number',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addNumber,
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: deleteNumber,
                  child: Text('Delete'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Numbers: ${numberList.join("  ")}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
