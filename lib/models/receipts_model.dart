import 'dart:ffi';

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
  final Medicine medicine;

  PastMedicine.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity	'],
        pricePerMedicineAtPurchase = json['price_per_medicine_at_purchase'],
        medicine = json['medicine'];
}

class Medicine {
  final int id;
  final String name;
  final String company;
  final int price;
  final Float averageRating;
  final int reviewCount;
  final int remaining;
  final String imgURL;

  Medicine.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        company = json['company'],
        price = json['price'],
        averageRating = json['average_rating'],
        reviewCount = json['review_count'],
        remaining = json['remaining'],
        imgURL = json['img_url'];
}
