class InventoriesModel {
  final int quantity;
  final int medicineId;
  final String medicineName;
  final String medicineCompany;
  final int medicinePrice;

  InventoriesModel.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        medicineId = json['medicine']['id'],
        medicineName = json['medicine']['name'],
        medicineCompany = json['medicine']['company'],
        medicinePrice = json['medicine']['price'];
}
