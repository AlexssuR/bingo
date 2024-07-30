import 'package:flutter/material.dart';

class BingoCardOptions extends StatelessWidget {
  final int selectedRows;
  final int selectedColumns;
  final void Function(int rows, int columns) addGrid;
  final List<DropdownMenuItem<int>> dropDownListItem;
  final void Function(int?) setRowsNumber;
  final void Function(int?) setColumnsNumber;
  final VoidCallback deleteGrid;

  BingoCardOptions({
    super.key,
    required this.selectedRows,
    required this.selectedColumns,
    required this.addGrid,
    required this.dropDownListItem,
    required this.setRowsNumber,
    required this.setColumnsNumber,
    required this.deleteGrid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Rows:'),
        DropdownButton<int>(
          value: selectedRows,
          items: dropDownListItem,
          onChanged: setRowsNumber,
        ),
        Text('Columns:'),
        DropdownButton<int>(
          value: selectedColumns,
          items: dropDownListItem,
          onChanged: setColumnsNumber,
        ),
        ElevatedButton(
          onPressed: () => addGrid(selectedRows, selectedColumns),
          child: Text('Add Card'),
        ),
        ElevatedButton(
          onPressed: deleteGrid,
          child: Text('Remove Card'),
        ),
      ],
    );
  }
}
