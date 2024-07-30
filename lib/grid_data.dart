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
