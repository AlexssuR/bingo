import 'package:flutter/material.dart';

class SelectNumberWidget extends StatelessWidget {
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
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  addNumber();
                }
              },
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
                ElevatedButton(
                  onPressed: deleteAllNumbers,
                  child: Text('Delete All'),
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
