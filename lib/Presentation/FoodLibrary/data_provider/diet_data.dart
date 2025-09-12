import 'models/diet_model.dart';

class DietData {

  static const List<DietModel> dietList = [
    DietModel(
      name: "Gluten Free",
      description: "Eliminating gluten means avoiding wheat, barley, rye, and other gluten-containing grains and foods made from them.",
    ),
    DietModel(
      name: "Ketogenic",
      description: "The keto diet is based more on the ratio of fat, protein, and carbs in the diet rather than specific ingredients.",
    ),
    DietModel(
      name: "Vegetarian",
      description: "No ingredients may contain meat or meat by-products, such as bones or gelatin.",
    ),
    DietModel(
      name: "Lacto-Vegetarian",
      description: "All ingredients must be vegetarian and none of the ingredients can be or contain egg.",
    ),
    DietModel(
      name: "Ovo-Vegetarian",
      description: "All ingredients must be vegetarian and none of the ingredients can be or contain dairy.",
    ),
    DietModel(
      name: "Vegan",
      description: "No ingredients may contain meat or meat by-products, such as bones or gelatin, nor may they contain eggs, dairy, or honey.",
    ),
    DietModel(
      name: "Pescetarian",
      description: "Everything is allowed except meat and meat by-products - some pescetarians eat eggs and dairy, some do not.",
    ),
    DietModel(
      name: "Paleo",
      description: "Allowed ingredients include meat (especially grass fed), fish, eggs, vegetables, some oils (e.g. coconut and olive oil), and in smaller quantities, fruit, nuts, and sweet potatoes.",
    ),
    DietModel(
      name: "Primal",
      description: "Very similar to Paleo, except dairy is allowed - think raw and full fat milk, butter, ghee, etc.",
    ),
    DietModel(
      name: "Low FODMAP",
      description: "FODMAP stands for 'fermentable oligo-, di-, mono-saccharides and polyols'. Our ontology knows which foods are considered high in these types of carbohydrates.",
    ),
    DietModel(
      name: "Whole30",
      description: "Allowed ingredients include meat, fish/seafood, eggs, vegetables, fresh fruit, coconut oil, olive oil, small amounts of dried fruit and nuts/seeds.",
    ),
  ];
}