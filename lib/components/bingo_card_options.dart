import 'package:flutter/material.dart';

class BingoCardOptions extends StatelessWidget {
  final VoidCallback addGrid;
  final List<DropdownMenuItem<int>> dropDownListItem;
  final VoidCallback deleteGrid;
  final int itemsPerRow;
  final void Function(int?) setItemsPerRow;

  BingoCardOptions(
      {super.key,
      required this.addGrid,
      required this.dropDownListItem,
      required this.deleteGrid,
      required this.itemsPerRow,
      required this.setItemsPerRow});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Add line selector
        Text('Card for Line:'),
        DropdownButton<int>(
          value: itemsPerRow,
          items: dropDownListItem,
          onChanged: setItemsPerRow,
        ),

        ElevatedButton(
          onPressed: addGrid,
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
