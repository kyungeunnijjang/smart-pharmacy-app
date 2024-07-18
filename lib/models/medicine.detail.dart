class MedicineDetailModel {
  final int id;
  final String createdAt;
  final String updatedAt;
  final int serialNumber;
  final String name;
  final String mainIngredient;
  final String efficacy;
  final String usage;
  final String needToKnow;
  final String cautions;
  final String bewareFood;
  final String sideEffect;
  final String howToStore;
  final int price;
  final double averageRating;
  final int reviewCount;
  final bool isFavorite;
  final String imgURL;

  MedicineDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        serialNumber = json['serial_number'],
        name = json['name'],
        mainIngredient = json['main_ingredient'],
        efficacy = json['efficacy'],
        usage = json['usage'],
        needToKnow = json['need_to_know'],
        cautions = json['cautions'],
        bewareFood = json['beware_food'],
        sideEffect = json['side_effect'],
        howToStore = json['how_to_store'],
        price = json['price'],
        averageRating = json['average_rating'],
        reviewCount = json['review_count'],
        isFavorite = json['is_favorite'],
        imgURL = json['img_url'];
}

class MedicineTinyModel {
  final int id;
  final String name;
  final String company;
  final int price;
  final double averageRating;
  final int reviewCount;
  final int remaining;
  final String imgURL;

  MedicineTinyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        company = json['company'],
        price = json['price'],
        averageRating = json['average_rating'],
        reviewCount = json['review_count'],
        remaining = json['remaining'],
        imgURL = json['img_url'];
}


