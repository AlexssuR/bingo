import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class GridData {
  int rows;
  int columns;
  List<List<String>> gridValues;

  GridData(this.rows, this.columns)
      : gridValues = List.generate(
          rows,
          (i) => List.filled(columns, ""),
        );
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
  int selectedRows = 2;
  int selectedColumns = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSelectNumberWidget(),
          _buildGridSelector(),
          Expanded(
            child: ListView.builder(
              itemCount: gridList.length,
              itemBuilder: (context, index) {
                return _buildGridItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectNumberWidget() {
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
                  onPressed: _addNumber,
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: _deleteNumber,
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

  Widget _buildGridSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Rows:'),
        DropdownButton<int>(
          value: selectedRows,
          items: _buildDropdownItems(),
          onChanged: (value) {
            setState(() {
              selectedRows = value!;
            });
          },
        ),
        Text('Columns:'),
        DropdownButton<int>(
          value: selectedColumns,
          items: _buildDropdownItems(),
          onChanged: (value) {
            setState(() {
              selectedColumns = value!;
            });
          },
        ),
        ElevatedButton(
          onPressed: () => _addGrid(selectedRows, selectedColumns),
          child: Text('Add Card'),
        ),
        ElevatedButton(
          onPressed: () => _deleteLastGrid(),
          child: Text('Remove Card'),
        ),
      ],
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

  Widget _buildGridItem(int index) {
    final gridData = gridList[index];
    final cellSize = 40.0;
    final gridWidth = gridData.columns * cellSize;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Card ${index + 1} - ${gridData.rows}x${gridData.columns}'),
            SizedBox(height: 8),
            Container(
              height: gridData.rows * cellSize,
              width: gridWidth,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridData.columns,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, itemIndex) {
                  final cellValue =
                      gridData.gridValues[itemIndex ~/ gridData.columns]
                          [itemIndex % gridData.columns];
                  return Container(
                    height: cellSize,
                    width: cellSize,
                    decoration: BoxDecoration(
                      color: (cellValue != '' &&
                              numberList.contains(int.parse(cellValue)))
                          ? Colors.blue[900]
                          : Colors.transparent,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: TextField(
                        style: TextStyle(
                            color: (cellValue != '' &&
                                    numberList.contains(int.parse(cellValue)))
                                ? Colors.white
                                : Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                              2), // Limit input to 2 characters
                        ],
                        onChanged: (text) {
                          // Update the grid value when valid text changes
                          if (text.isNotEmpty) {
                            final int parsedValue = int.parse(text);
                            if (parsedValue >= 0 && parsedValue <= 99) {
                              _updateGridValue(index, itemIndex, text);
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
                itemCount: gridData.rows * gridData.columns,
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
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

  void _updateGridValue(int gridIndex, int itemIndex, String value) {
    setState(() {
      //final reversedValue = value.split('').reversed.join('');
      gridList[gridIndex].gridValues[itemIndex ~/ gridList[gridIndex].columns]
          [itemIndex % gridList[gridIndex].columns] = value;
    });
  }
}
