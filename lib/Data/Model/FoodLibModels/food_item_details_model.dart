class FoodItemDetailsModel {
  int? id;
  String? image;
  String? imageType;
  String? title;
  num? readyInMinutes;
  num? servings;
  String? sourceUrl;
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  bool? lowFodmap;
  num? weightWatcherSmartPoints;
  String? gaps;
  num? preparationMinutes;
  num? cookingMinutes;
  num? aggregateLikes;
  num? healthScore;
  String? creditsText;
  dynamic license;
  String? sourceName;
  double? pricePerServing;
  List<ExtendedIngredients>? extendedIngredients;
  Nutrition? nutrition;
  String? summary;
  List<String>? cuisines;
  List<String>? dishTypes;
  List<String>? diets;
  String? instructions;
  List<AnalyzedInstructions>? analyzedInstructions;
  double? spoonacularScore;
  String? spoonacularSourceUrl;

  FoodItemDetailsModel(
      {this.id,
        this.image,
        this.imageType,
        this.title,
        this.readyInMinutes,
        this.servings,
        this.sourceUrl,
        this.vegetarian,
        this.vegan,
        this.glutenFree,
        this.dairyFree,
        this.veryHealthy,
        this.cheap,
        this.veryPopular,
        this.sustainable,
        this.lowFodmap,
        this.weightWatcherSmartPoints,
        this.gaps,
        this.preparationMinutes,
        this.cookingMinutes,
        this.aggregateLikes,
        this.healthScore,
        this.creditsText,
        this.license,
        this.sourceName,
        this.pricePerServing,
        this.extendedIngredients,
        this.nutrition,
        this.summary,
        this.cuisines,
        this.dishTypes,
        this.diets,
        this.instructions,
        this.analyzedInstructions,
        this.spoonacularScore,
        this.spoonacularSourceUrl});

  FoodItemDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    imageType = json['imageType'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
    vegetarian = json['vegetarian'];
    vegan = json['vegan'];
    glutenFree = json['glutenFree'];
    dairyFree = json['dairyFree'];
    veryHealthy = json['veryHealthy'];
    cheap = json['cheap'];
    veryPopular = json['veryPopular'];
    sustainable = json['sustainable'];
    lowFodmap = json['lowFodmap'];
    weightWatcherSmartPoints = json['weightWatcherSmartPoints'];
    gaps = json['gaps'];
    preparationMinutes = json['preparationMinutes'];
    cookingMinutes = json['cookingMinutes'];
    aggregateLikes = json['aggregateLikes'];
    healthScore = json['healthScore'];
    creditsText = json['creditsText'];
    license = json['license'];
    sourceName = json['sourceName'];
    pricePerServing = json['pricePerServing'];
    if (json['extendedIngredients'] != null) {
      extendedIngredients = <ExtendedIngredients>[];
      json['extendedIngredients'].forEach((v) {
        extendedIngredients!.add(ExtendedIngredients.fromJson(v));
      });
    }
    nutrition = json['nutrition'] != null
        ? Nutrition.fromJson(json['nutrition'])
        : null;
    summary = json['summary'];
    cuisines = json['cuisines'].cast<String>();
    dishTypes = json['dishTypes'].cast<String>();
    diets = json['diets'].cast<String>();
    instructions = json['instructions'];
    if (json['analyzedInstructions'] != null) {
      analyzedInstructions = <AnalyzedInstructions>[];
      json['analyzedInstructions'].forEach((v) {
        analyzedInstructions!.add(AnalyzedInstructions.fromJson(v));
      });
    }
    spoonacularScore = json['spoonacularScore'];
    spoonacularSourceUrl = json['spoonacularSourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['imageType'] = imageType;
    data['title'] = title;
    data['readyInMinutes'] = readyInMinutes;
    data['servings'] = servings;
    data['sourceUrl'] = sourceUrl;
    data['vegetarian'] = vegetarian;
    data['vegan'] = vegan;
    data['glutenFree'] = glutenFree;
    data['dairyFree'] = dairyFree;
    data['veryHealthy'] = veryHealthy;
    data['cheap'] = cheap;
    data['veryPopular'] = veryPopular;
    data['sustainable'] = sustainable;
    data['lowFodmap'] = lowFodmap;
    data['weightWatcherSmartPoints'] = weightWatcherSmartPoints;
    data['gaps'] = gaps;
    data['preparationMinutes'] = preparationMinutes;
    data['cookingMinutes'] = cookingMinutes;
    data['aggregateLikes'] = aggregateLikes;
    data['healthScore'] = healthScore;
    data['creditsText'] = creditsText;
    data['license'] = license;
    data['sourceName'] = sourceName;
    data['pricePerServing'] = pricePerServing;
    if (extendedIngredients != null) {
      data['extendedIngredients'] =
          extendedIngredients!.map((v) => v.toJson()).toList();
    }
    if (nutrition != null) {
      data['nutrition'] = nutrition!.toJson();
    }
    data['summary'] = summary;
    data['cuisines'] = cuisines;
    data['dishTypes'] = dishTypes;
    data['diets'] = diets;
    data['instructions'] = instructions;
    if (analyzedInstructions != null) {
      data['analyzedInstructions'] =
          analyzedInstructions!.map((v) => v.toJson()).toList();
    }
    data['spoonacularScore'] = spoonacularScore;
    data['spoonacularSourceUrl'] = spoonacularSourceUrl;
    return data;
  }
}

class ExtendedIngredients {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalName;
  double? amount;
  String? unit;
  List<String>? meta;
  Measures? measures;

  ExtendedIngredients(
      {this.id,
        this.aisle,
        this.image,
        this.consistency,
        this.name,
        this.nameClean,
        this.original,
        this.originalName,
        this.amount,
        this.unit,
        this.meta,
        this.measures});

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aisle = json['aisle'];
    image = json['image'];
    consistency = json['consistency'];
    name = json['name'];
    nameClean = json['nameClean'];
    original = json['original'];
    originalName = json['originalName'];
    amount = json['amount'];
    unit = json['unit'];
    meta = json['meta'].cast<String>();
    measures = json['measures'] != null
        ? Measures.fromJson(json['measures'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aisle'] = aisle;
    data['image'] = image;
    data['consistency'] = consistency;
    data['name'] = name;
    data['nameClean'] = nameClean;
    data['original'] = original;
    data['originalName'] = originalName;
    data['amount'] = amount;
    data['unit'] = unit;
    data['meta'] = meta;
    if (measures != null) {
      data['measures'] = measures!.toJson();
    }
    return data;
  }
}

class Measures {
  Us? us;
  Us? metric;

  Measures({this.us, this.metric});

  Measures.fromJson(Map<String, dynamic> json) {
    us = json['us'] != null ? Us.fromJson(json['us']) : null;
    metric = json['metric'] != null ? Us.fromJson(json['metric']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (us != null) {
      data['us'] = us!.toJson();
    }
    if (metric != null) {
      data['metric'] = metric!.toJson();
    }
    return data;
  }
}

class Us {
  double? amount;
  String? unitShort;
  String? unitLong;

  Us({this.amount, this.unitShort, this.unitLong});

  Us.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unitShort = json['unitShort'];
    unitLong = json['unitLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unitShort'] = unitShort;
    data['unitLong'] = unitLong;
    return data;
  }
}

class Nutrition {
  List<Nutrients>? nutrients;
  CaloricBreakdown? caloricBreakdown;
  WeightPerServing? weightPerServing;

  Nutrition(
      {this.nutrients,
        this.caloricBreakdown,
        this.weightPerServing});

  Nutrition.fromJson(Map<String, dynamic> json) {
    if (json['nutrients'] != null) {
      nutrients = <Nutrients>[];
      json['nutrients'].forEach((v) {
        nutrients!.add(Nutrients.fromJson(v));
      });
    }
    caloricBreakdown = json['caloricBreakdown'] != null
        ? CaloricBreakdown.fromJson(json['caloricBreakdown'])
        : null;
    weightPerServing = json['weightPerServing'] != null
        ? WeightPerServing.fromJson(json['weightPerServing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nutrients != null) {
      data['nutrients'] = nutrients!.map((v) => v.toJson()).toList();
    }
    if (caloricBreakdown != null) {
      data['caloricBreakdown'] = caloricBreakdown!.toJson();
    }
    if (weightPerServing != null) {
      data['weightPerServing'] = weightPerServing!.toJson();
    }
    return data;
  }
}

class Nutrients {
  String? name;
  double? amount;
  String? unit;
  double? percentOfDailyNeeds;

  Nutrients({this.name, this.amount, this.unit, this.percentOfDailyNeeds});

  Nutrients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
    percentOfDailyNeeds = json['percentOfDailyNeeds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['unit'] = unit;
    data['percentOfDailyNeeds'] = percentOfDailyNeeds;
    return data;
  }
}

class Properties {
  String? name;
  double? amount;
  String? unit;

  Properties({this.name, this.amount, this.unit});

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['unit'] = unit;
    return data;
  }
}

class Ingredients {
  int? id;
  String? name;
  double? amount;
  String? unit;
  List<Nutrients>? nutrients;

  Ingredients({this.id, this.name, this.amount, this.unit, this.nutrients});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
    if (json['nutrients'] != null) {
      nutrients = <Nutrients>[];
      json['nutrients'].forEach((v) {
        nutrients!.add(Nutrients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['unit'] = unit;
    if (nutrients != null) {
      data['nutrients'] = nutrients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaloricBreakdown {
  double? percentProtein;
  double? percentFat;
  double? percentCarbs;

  CaloricBreakdown({this.percentProtein, this.percentFat, this.percentCarbs});

  CaloricBreakdown.fromJson(Map<String, dynamic> json) {
    percentProtein = json['percentProtein'];
    percentFat = json['percentFat'];
    percentCarbs = json['percentCarbs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentProtein'] = percentProtein;
    data['percentFat'] = percentFat;
    data['percentCarbs'] = percentCarbs;
    return data;
  }
}

class WeightPerServing {
  int? amount;
  String? unit;

  WeightPerServing({this.amount, this.unit});

  WeightPerServing.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unit'] = unit;
    return data;
  }
}

class AnalyzedInstructions {
  String? name;
  List<Steps>? steps;

  AnalyzedInstructions({this.name, this.steps});

  AnalyzedInstructions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  int? number;
  String? step;
  List<StepIngredients>? ingredients;
  Length? length;

  Steps(
      {this.number, this.step, this.ingredients, this.length});

  Steps.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    step = json['step'];
    if (json['ingredients'] != null) {
      ingredients = <StepIngredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(StepIngredients.fromJson(v));
      });
    }
    length = json['length'] != null ? Length.fromJson(json['length']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['step'] = step;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    if (length != null) {
      data['length'] = length!.toJson();
    }
    return data;
  }
}

class StepIngredients {
  int? id;
  String? name;
  String? localizedName;
  String? image;

  StepIngredients({this.id, this.name, this.localizedName, this.image});

  StepIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localizedName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['localizedName'] = localizedName;
    data['image'] = image;
    return data;
  }
}

class Length {
  num? number;
  String? unit;

  Length({this.number, this.unit});

  Length.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['unit'] = unit;
    return data;
  }
}
