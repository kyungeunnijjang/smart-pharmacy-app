class ReceiptsModel {
  final String purchaseAt;
  final int totalPrice;
  final List<PastMedicine> pastMedicines;

  ReceiptsModel({
    required this.purchaseAt,
    required this.totalPrice,
    required this.pastMedicines,
  });

  factory ReceiptsModel.fromJson(Map<String, dynamic> json) {
    var pastMedicinesFromJson = json['past_medicines'] as List;
    List<PastMedicine> pastMedicinesList =
        pastMedicinesFromJson.map((i) => PastMedicine.fromJson(i)).toList();

    return ReceiptsModel(
      purchaseAt: json['purchase_at'],
      totalPrice: json['total_price'],
      pastMedicines: pastMedicinesList,
    );
  }
}

class PastMedicine {
  final int quantity;
  final String pricePerMedicineAtPurchase;
  final Medicine medicine;

  PastMedicine({
    required this.quantity,
    required this.pricePerMedicineAtPurchase,
    required this.medicine,
  });

  factory PastMedicine.fromJson(Map<String, dynamic> json) {
    return PastMedicine(
      quantity: json['quantity'],
      pricePerMedicineAtPurchase: json['price_per_medicine_at_purchase'],
      medicine: Medicine.fromJson(json['medicine']),
    );
  }
}

class Medicine {
  final int id;
  final String name;
  final String company;
  final int price;

  Medicine({
    required this.id,
    required this.name,
    required this.company,
    required this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      company: json['company'],
      price: json['price'],
    );
  }
}
