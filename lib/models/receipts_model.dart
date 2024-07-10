class ReceiptsModel {
  final String putchaseAt;
  final int totalPrice;
  final int postMedicinesQuantity;
  final String postMedicinesPrice;
  final int postMedicinesMedicineId;
  final String postMedicinesMedicineName;
  final String postMedicinesMedicineComepany;
  final int postMedicinesMedicinePrice;

  ReceiptsModel.fromJson(Map<String, dynamic> json)
      : putchaseAt = json['purchase_at'],
        totalPrice = json['total_price'],
        postMedicinesQuantity = json['post_medicines']['quantity'],
        postMedicinesPrice =
            json['post_medicines']['price_per_medicine_at_purchase'],
        postMedicinesMedicineId = json['post_medicines']['medicine']['id'],
        postMedicinesMedicineName = json['post_medicines']['medicine']['name'],
        postMedicinesMedicineComepany =
            json['post_medicines']['medicine']['company'],
        postMedicinesMedicinePrice =
            json['post_medicines']['medicine']['price'];
}
