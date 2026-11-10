import 'dart:io';

import 'package:bingo/components/bingo_card.dart';
import 'package:bingo/components/bingo_card_options.dart';
import 'package:bingo/components/number_selector.dart';
import 'package:bingo/master_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'grid_data.dart';

import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    // If the environment variables are not set, use the default values
    cardTotalRows = 3;
    cardTotalColumns = 9;
    minItemsPerRow = 1;
    maxItemsPerRow = 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Column(
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
                      (gridList.length / itemsPerRow).ceil(),
                      (rowIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: List.generate(itemsPerRow, (itemIndex) {
                              final currentIndex =
                                  rowIndex * itemsPerRow + itemIndex;
                              if (currentIndex < gridList.length) {
                                return Expanded(
                                  child: BingoCard(
                                    index: currentIndex,
                                    gridList: gridList,
                                    numberList: numberList,
                                    updateGridValue: _updateGridValue,
                                  ),
                                );
                              } else {
                                return Expanded(child: Container());
                              }
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Bottom-right corner link
          Positioned(
            bottom: 16,
            right: 16,
            child: TextButton(
              onPressed: () async {
                bool? confirm = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text(
                        "If you decide to be the Master you cannot go back, all your progress will be lost",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // User cancels
                          },
                          child: const Text("Nah, I'm good"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // User confirms
                          },
                          child: const Text("Absolutely!"),
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MasterPage()),
                  );
                }
              },
              child: const Text(
                "Go to MasterPage",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
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
    gridList[gridIndex].gridValues[itemIndex ~/
            gridList[gridIndex].columns][itemIndex %
            gridList[gridIndex].columns] =
        value;
  }
}
