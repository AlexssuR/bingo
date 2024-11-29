import 'dart:io';
import 'package:bingo/components/bingo_card.dart';
import 'package:bingo/components/bingo_card_options.dart';
import 'package:bingo/components/number_selector.dart';
import 'package:flutter/material.dart';
import 'grid_data.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  List<int> numberList = [];
  TextEditingController numberController = TextEditingController();

  List<GridData> gridList = [new GridData(10, 9, useProgressiveNumbers: true)];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SelectNumberWidget(
            numberController: numberController,
            numberList: numberList,
            addNumber: _addNumber,
            deleteNumber: _deleteNumber,
            deleteAllNumbers: _deleteAllNumbers,
          ),
          Expanded(
              child: BingoCard(
                  index: 0,
                  gridList: gridList,
                  numberList: numberList,
                  updateGridValue: _updateGridValue)),
        ],
      ),
    );
  }

  void _addNumber() {
    // Get the number from the text field
    int? newNumber = int.tryParse(numberController.text);

    // Check if the number is not null and not already in the list
    if (newNumber != null && !numberList.contains(newNumber)) {
      setState(() {
        numberList.add(newNumber);
        numberController.clear();
      });
    }
  }

  void _deleteNumber() {
    // Get the number from the text field
    int? numberToDelete = int.tryParse(numberController.text);

    // Check if the number is in the list and delete it
    if (numberList.contains(numberToDelete)) {
      setState(() {
        numberList.remove(numberToDelete);
        numberController.clear();
      });
    }
  }

  void _deleteAllNumbers() {
    // Check if the number list is not empty
    if (numberList.isNotEmpty) {
      setState(() {
        numberList.clear();
      });
    }
  }

  void _updateGridValue(int gridIndex, int itemIndex, String value) {
    gridList[gridIndex].gridValues[itemIndex ~/ gridList[gridIndex].columns]
        [itemIndex % gridList[gridIndex].columns] = value;
  }
}
