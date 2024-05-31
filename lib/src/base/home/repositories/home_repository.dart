import 'package:greengrocer/src/base/home/results/home_result.dart';
import 'package:greengrocer/src/base/models/item_model.dart';
import 'package:greengrocer/src/common/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await httpManager.restRequest(
      url: Endpoints.getCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.sucess(data);
    } else {
      return HomeResult.error('Ocorreu um erro ao recuperar as Categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await httpManager.restRequest(
        url: Endpoints.getProducts, method: HttpMethods.post, body: body);
    if (result['result'] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
          .map(ItemModel.fromJson)
          .toList();
      return HomeResult<ItemModel>.sucess(data);
    } else {
      return HomeResult.error('Ocorreu um erro');
    }
  }
}
