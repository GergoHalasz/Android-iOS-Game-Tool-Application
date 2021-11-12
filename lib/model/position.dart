///User for arrow position on the screen
class Position {
  final int row;
  final int column;

  Position({
    required int row,
    required int column,
  })  : row = row + 1,
        column = column + 1;
}
