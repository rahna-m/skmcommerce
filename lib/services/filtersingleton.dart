// import 'package:syncfusion_flutter_sliders/sliders.dart';

// class FilterSingleton {
//   FilterSingleton._internal();
//   static final FilterSingleton instance = FilterSingleton._internal();
//   List<String> _seletedCategory = [];
//   bool _featuredflag = false;
//   bool _priceRangeFlag = true;
//   SfRangeValues _priceRange = SfRangeValues(0.0, 1000.0);
//   factory FilterSingleton() {
//     return instance;
//   }
//   List<String> get SeletedCategory => _seletedCategory;
//   bool get featuredFlag => _featuredflag;
//   bool get priceRangeFlag => _priceRangeFlag;
//   SfRangeValues get priceRange => _priceRange;
//   void setFilter(val) {
//     if (_seletedCategory.contains(val)) {
//       _seletedCategory.removeWhere((item) => item == val);
//     } else {
//       _seletedCategory.add(val);
//     }
//   }

//   void setFeatured() {
//     _featuredflag = !_featuredflag;
//   }

//   void setPriceRange(SfRangeValues values) {
//     _priceRange = values;
//   }

//   void togglePriceRage() {
//     _priceRangeFlag = !priceRangeFlag;
//   }

//   void resetFilter() {
//     _featuredflag = false;
//     _priceRange = SfRangeValues(0.0, 1000.0);
//     _seletedCategory.clear();
//     _priceRangeFlag = true;
//   }
// }

import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterSingleton {
  FilterSingleton._internal();
  static final FilterSingleton instance = FilterSingleton._internal();

  // Private fields
  List<String> _selectedCategory = [];
  bool _featuredFlag = false;
  bool _priceRangeFlag = true;
  SfRangeValues _priceRange = SfRangeValues(0.0, 1000.0);

  // Factory constructor
  factory FilterSingleton() {
    return instance;
  }

  // Getters
  List<String> get selectedCategory => _selectedCategory;
  bool get featuredFlag => _featuredFlag;
  bool get priceRangeFlag => _priceRangeFlag;
  SfRangeValues get priceRange => _priceRange;

  // Methods to modify filters
  void setFilter(String val) {
    if (_selectedCategory.contains(val)) {
      _selectedCategory.removeWhere((item) => item == val);
    } else {
      _selectedCategory.add(val);
    }
  }

  void setFeatured() {
    _featuredFlag = !_featuredFlag;
  }

  void setPriceRange(SfRangeValues values) {
    _priceRange = values;
  }

  void togglePriceRange() {
    _priceRangeFlag = !_priceRangeFlag;
  }

  void resetFilter() {
    _featuredFlag = false;
    _priceRange = SfRangeValues(0.0, 1000.0);
    _selectedCategory.clear();
    _priceRangeFlag = true;
  }

  // Build filter query for API requests
  String buildFilterQuery() {
    List<String> filters = [];

    if (_selectedCategory.isNotEmpty) {
      filters.add(
        _selectedCategory.map((id) => '(category = "$id")').join(" || "),
      );
    }

    if (_priceRange.start > 0 || _priceRange.end < 1000) {
      filters.add(
          '(discount_price >= ${_priceRange.start} && discount_price <= ${_priceRange.end})');
    }

    if (_featuredFlag) {
      filters.add('(featured = true)');
    }

    return filters.isNotEmpty ? "(${filters.join(' && ')})" : "";
  }
}
