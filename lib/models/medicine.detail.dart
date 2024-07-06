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
        price = json['price'];
}
