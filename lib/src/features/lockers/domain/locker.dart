class Locker {
  Locker({
    required this.id,
    required this.floor,
    required this.isAvailable,
    required this.responsable,
  });

  final String id;
  final String floor;
  final bool isAvailable;
  final String responsable;
  final int? nbrCle = 0;
  final int? noSerrure = 0;

  factory Locker.fromExcel(List<String> rowData) {
    if (rowData.length < 6) {
      rowData.add('');
    }
    return Locker(
      id: rowData[1],
      floor: rowData[0],
      responsable: rowData[2],
      isAvailable: rowData[3].isNotEmpty,
    );
  }
}
