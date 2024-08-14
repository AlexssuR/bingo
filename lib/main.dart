import 'dart:io';

import 'package:bingo/components/bingo_card.dart';
import 'package:bingo/components/bingo_card_options.dart';
import 'package:bingo/components/number_selector.dart';
import 'package:flutter/material.dart';
import 'grid_data.dart';

void main() {
  runApp(BingoApp());
}

class BingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> numberList = [];
  TextEditingController numberController = TextEditingController();
  List<GridData> gridList = [];
  late int cardTotalRows;
  late int cardTotalColumns;

  int itemsPerRow = 1;

  late int maxItemsPerRow;
  late int minItemsPerRow;

  @override
  void initState() {
    super.initState();

    String? envRows = Platform.environment['CARD_ROWS'];
    String? envColumns = Platform.environment['CARD_COLUMNS'];
    // If the environment variables are not set, use the default values

    cardTotalRows = envRows != null ? int.tryParse(envRows) ?? 4 : 4;
    cardTotalColumns = envColumns != null ? int.tryParse(envColumns) ?? 9 : 9;

    String? minItems = Platform.environment['MIN_ITEMS'];
    String? maxItems = Platform.environment['MAX_ITEMS'];

    minItemsPerRow = minItems != null ? int.tryParse(minItems) ?? 1 : 1;
    maxItemsPerRow = maxItems != null ? int.tryParse(maxItems) ?? 4 : 4;
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
          BingoCardOptions(
            addGrid: _addGrid,
            dropDownListItem: _buildDropdownItems(),
            deleteGrid: _deleteLastGrid,
            itemsPerRow: itemsPerRow,
            increaseItemsPerRow: _increaseItemsPerRow,
            decreaseItemsPerRow: _decreaseItemsPerRow,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  (gridList.length / itemsPerRow)
                      .ceil(), // Number of rows needed
                  (rowIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: List.generate(
                          itemsPerRow,
                          (itemIndex) {
                            final currentIndex =
                                rowIndex * itemsPerRow + itemIndex;
                            if (currentIndex < gridList.length) {
                              return Expanded(
                                  child: BingoCard(
                                      index: currentIndex,
                                      gridList: gridList,
                                      numberList: numberList,
                                      updateGridValue: _updateGridValue));
                            } else {
                              return Expanded(
                                  child:
                                      Container()); // Placeholder for empty spaces
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildDropdownItems() {
    return List.generate(
      10,
      (index) => DropdownMenuItem<int>(
        value: index + 1,
        child: Text((index + 1).toString()),
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

  void _addGrid() {
    setState(() {
      gridList.add(GridData(cardTotalRows, cardTotalColumns));
    });
  }

  void _deleteLastGrid() {
    setState(() {
      if (gridList.isNotEmpty) {
        gridList.removeLast();
      }
    });
  }

  void _increaseItemsPerRow() {
    setState(() {
      if (itemsPerRow < maxItemsPerRow) {
        itemsPerRow++;
      }
    });
  }

  void _decreaseItemsPerRow() {
    setState(() {
      if (itemsPerRow > minItemsPerRow) {
        itemsPerRow--;
      }
    });
  }

  void _updateGridValue(int gridIndex, int itemIndex, String value) {
    gridList[gridIndex].gridValues[itemIndex ~/ gridList[gridIndex].columns]
        [itemIndex % gridList[gridIndex].columns] = value;
  }
}
