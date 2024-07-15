class MedicineDetailModel {
  final int id;
  final String name;
  final String efficacy;
  final String bewareFood;
  final String sideEffect;
  final int price;

  MedicineDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        efficacy = json['efficacy'],
        bewareFood = json['beware_food'],
        sideEffect = json['side_effect'],
        price = json['price'];
}
