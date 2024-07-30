import 'package:bingo/components/bingo_card.dart';
import 'package:bingo/components/bingo_card_options.dart';
import 'package:bingo/components/number_selector.dart';
import 'package:flutter/material.dart';
import 'grid_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final int squareSize = 50;
  int selectedRows = 5;
  int selectedColumns = 10;
  int itemsPerRow = 2;

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
          ),
          BingoCardOptions(
              selectedRows: selectedRows,
              selectedColumns: selectedColumns,
              addGrid: _addGrid,
              dropDownListItem: _buildDropdownItems(),
              setRowsNumber: _setRowsNumber,
              setColumnsNumber: _setColumnsNumber,
              deleteGrid: _deleteLastGrid),
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

  void _addGrid(int rows, int columns) {
    setState(() {
      gridList.add(GridData(rows, columns));
    });
  }

  void _deleteLastGrid() {
    setState(() {
      gridList.removeLast();
    });
  }

  void _setColumnsNumber(value) {
    setState(() {
      selectedColumns = value!;
    });
  }

  void _setRowsNumber(value) {
    setState(() {
      selectedRows = value!;
    });
  }

  void _updateGridValue(int gridIndex, int itemIndex, String value) {
    gridList[gridIndex].gridValues[itemIndex ~/ gridList[gridIndex].columns]
        [itemIndex % gridList[gridIndex].columns] = value;
  }
}
