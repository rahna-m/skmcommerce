import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterSingleton {
  FilterSingleton._internal();
  static final FilterSingleton instance = FilterSingleton._internal();
  List<String> _seletedCategory = [];
  bool _featuredflag = false;
  bool _priceRangeFlag = true;
  SfRangeValues _priceRange = SfRangeValues(0.0, 1000.0);
  factory FilterSingleton() {
    return instance;
  }
  List<String> get SeletedCategory => _seletedCategory;
  bool get featuredFlag => _featuredflag;
  bool get priceRangeFlag => _priceRangeFlag;
  SfRangeValues get priceRange => _priceRange;
  void setFilter(val) {
    if (_seletedCategory.contains(val)) {
      _seletedCategory.removeWhere((item) => item == val);
    } else {
      _seletedCategory.add(val);
    }
  }

  void setFeatured() {
    _featuredflag = !_featuredflag;
  }

  void setPriceRange(SfRangeValues values) {
    _priceRange = values;
  }

  void togglePriceRage() {
    _priceRangeFlag = !priceRangeFlag;
  }

  void resetFilter() {
    _featuredflag = false;
    _priceRange = SfRangeValues(0.0, 1000.0);
    _seletedCategory.clear();
    _priceRangeFlag = true;
  }
}