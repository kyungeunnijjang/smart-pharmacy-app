import 'package:pharmacy_app/models/medicine.detail.dart';

class ReceiptModel {
  final String purchaseAt;
  final int totalPrice;
  final List<PastMedicine> pastMedicines;

  ReceiptModel.fromJson(Map<String, dynamic> json)
      : purchaseAt = json['purchase_at'],
        totalPrice = json['total_price'],
        pastMedicines = json['past_medicines'];
}

class PastMedicine {
  final int quantity;
  final String pricePerMedicineAtPurchase;
  final MedicineTinyModel medicine;

  PastMedicine.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity	'],
        pricePerMedicineAtPurchase = json['price_per_medicine_at_purchase'],
        medicine = json['medicine'];
}
