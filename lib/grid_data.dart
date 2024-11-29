class GridData {
  int rows;
  int columns;
  List<List<String>> gridValues;

  GridData(this.rows, this.columns, {bool useProgressiveNumbers = false})
      : gridValues = List.generate(
          rows,
          (i) => List.generate(
            columns,
            (j) {
              if (useProgressiveNumbers) {
                int value = i * columns + j + 1; // Calculate progressive number
                return value
                    .toString(); // Always fill with numbers starting from 1
              } else {
                return ""; // Default empty string
              }
            },
          ),
        );
}
