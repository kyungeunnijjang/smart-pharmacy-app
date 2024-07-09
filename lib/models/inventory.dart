class InventoryModel {
  final int id;
  final int quantity;
  final int medicineId;
  final String medicineName;
  final String medicineCompany;
  final int medicinePrice;

  InventoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'],
        medicineId = json['medicine']['id'],
        medicineName = json['medicine']['name'],
        medicineCompany = json['medicine']['company'],
        medicinePrice = json['medicine']['price'];
}
