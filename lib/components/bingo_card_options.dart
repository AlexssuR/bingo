import 'package:flutter/material.dart';

class BingoCardOptions extends StatelessWidget {
  final VoidCallback addGrid;
  final List<DropdownMenuItem<int>> dropDownListItem;
  final VoidCallback deleteGrid;
  final int itemsPerRow;
  final VoidCallback increaseItemsPerRow;
  final VoidCallback decreaseItemsPerRow;

  const BingoCardOptions({
    super.key,
    required this.addGrid,
    required this.dropDownListItem,
    required this.deleteGrid,
    required this.itemsPerRow,
    required this.increaseItemsPerRow,
    required this.decreaseItemsPerRow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: decreaseItemsPerRow,
            ),
            Text('Items per row: $itemsPerRow'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: increaseItemsPerRow,
            ),
          ],
        ),
        ElevatedButton(onPressed: addGrid, child: const Text('Add Card')),
        ElevatedButton(onPressed: deleteGrid, child: const Text('Remove Card')),
      ],
    );
  }
}
