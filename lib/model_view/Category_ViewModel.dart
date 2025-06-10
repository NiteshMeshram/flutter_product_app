import 'package:product_app/Utils/NetworkManager.dart';

import '../model/Category.dart';

class CategoryViewModel {
  final NetworkManager _networkManager = NetworkManager.instance;

  get fromJson => null;

  Future<List<Category>> getCategory() async {
    print("getCategory called : 1");
    try {
      final categories = await _networkManager.request<List<Category>>(
        urlString: 'https://api.escuelajs.co/api/v1/categories',
        fromJson: (json) =>
            (json as List).map((item) => Category.fromJson(item)).toList(),
      );
      return categories ?? [];
    } catch (e) {
      // Handle error as needed
      rethrow;
    }
  }
}
