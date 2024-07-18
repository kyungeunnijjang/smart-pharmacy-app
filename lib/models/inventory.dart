class InventoryModel {
  final int id;
  final int quantity;
  final int medicineId;
  final String medicineName;
  final String medicineCompany;
  final int medicinePrice;
  final int medicineRemaining;

  InventoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'],
        medicineId = json['medicine']['id'],
        medicineName = json['medicine']['name'],
        medicineCompany = json['medicine']['company'],
        medicinePrice = json['medicine']['price'],
        medicineRemaining = json['medicine']['remaining'] ?? 0;

  set quantity(int value) {
    quantity = value;
  }
}
