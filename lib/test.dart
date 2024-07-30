import 'package:bingo/components/number_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid of TextFields in Cards'),
        ),
        body: Column(children: [
          SelectNumberWidget(
            numberController: new TextEditingController(),
            numberList: [1, 2, 3],
            addNumber: () {},
            deleteNumber: () {},
          ),
          SingleChildScrollView(
            child: MultipleCardGrids(
              rows: 5, // Number of rows in each grid
              columns: 10, // Number of columns in each grid
              numberOfGrids: 7, // Number of grids
              gridsPerRow: 2, // Number of grids per row in the larger grid
            ),
          )
        ]),
      ),
    );
  }
}

class SingleCardGrid extends StatelessWidget {
  final int rows;
  final int columns;
  final double textFieldSize = 40.0; // Fixed size for each TextField

  SingleCardGrid({required this.rows, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0), // Margin around each card
      child: Column(
        children: List.generate(rows, (rowIndex) {
          return Row(
            children: List.generate(columns, (colIndex) {
              return SizedBox(
                width: textFieldSize,
                height: textFieldSize,
                child: TextField(
                  maxLength: 2,
                  decoration: InputDecoration(
                    counterText: "", // Remove the character counter
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(
                        8.0), // Adjust padding to ensure two characters fit well
                    isDense: true, // Make the TextField more compact
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16), // Adjust font size as needed
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

class MultipleCardGrids extends StatelessWidget {
  final int rows;
  final int columns;
  final int numberOfGrids;
  final int gridsPerRow;
  final double textFieldSize = 40.0; // Fixed size for each TextField

  MultipleCardGrids({
    required this.rows,
    required this.columns,
    required this.numberOfGrids,
    required this.gridsPerRow,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> gridRows = [];
    for (int i = 0; i < numberOfGrids; i += gridsPerRow) {
      List<Widget> gridColumns = [];
      for (int j = 0; j < gridsPerRow && i + j < numberOfGrids; j++) {
        gridColumns.add(SingleCardGrid(rows: rows, columns: columns));
      }
      gridRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: gridColumns,
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: gridRows,
    );
  }
}
