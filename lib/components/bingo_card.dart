import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../grid_data.dart';

class BingoCard extends StatelessWidget {
  final int index;
  final List<GridData> gridList;
  final List<int> numberList;
  final void Function(int, int, String) updateGridValue;

  BingoCard(
      {super.key,
      required this.index,
      required this.gridList,
      required this.numberList,
      required this.updateGridValue});

  @override
  Widget build(BuildContext context) {
    final gridData = gridList[index];
    final cellSize = 40.0;
    final gridWidth = gridData.columns * cellSize;
    //Define and initialize text controller for each element of the grid
    List<List<TextEditingController>> textfieldsControllers = List.generate(
      gridData.rows, // Number of rows
      (index) => List.generate(
        gridData.columns, // Number of columns
        (index) => (TextEditingController()),
      ),
    );
    //Fill the controller's text with the corresponding value of the structure
    for (int i = 0; i < gridData.rows; i++) {
      for (int j = 0; j < gridData.columns; j++) {
        textfieldsControllers[i][j].text =
            gridData.gridValues[i][j]; //corresponding value grid
      }
    }
    return Column(
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
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        // If the new value is empty, accept the change (allow clearing)
                        return newValue;
                      }
                      final parsed = int.tryParse(newValue.text);
                      if (parsed == null || parsed <= 0 || parsed > 90) {
                        // If the new value is not valid, reject the change
                        return oldValue;
                      }
                      // Otherwise, accept the change
                      return newValue;
                    }),
                  ],
                  //Add the correspondinf controller from the list
                  controller:
                      textfieldsControllers[itemIndex ~/ gridData.columns]
                          [itemIndex % gridData.columns],
                  onChanged: (text) {
                    updateGridValue(index, itemIndex, text);
                  },
                ),
              );
            },
            itemCount: gridData.rows * gridData.columns,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
/* final int selectedRows;
  final int selectedColumns;
  final void Function(int rows, int columns) addGrid;
  final List<DropdownMenuItem<int>> dropDownListItem;
  final void Function(int?) setRowsNumber;
  final void Function(int?) setColumnsNumber;
  final VoidCallback deleteGrid;

  CardOptions({
    super.key,
    required this.selectedRows,
    required this.selectedColumns,
    required this.addGrid,
    required this.dropDownListItem,
    required this.setRowsNumber,
    required this.setColumnsNumber,
    required this.deleteGrid,
  }); */

 