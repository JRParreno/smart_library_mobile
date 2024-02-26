import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/core/interceptor/api_interceptor.dart';
import 'package:smart_libary_app/src/department/data/models/department_model.dart';
import 'package:smart_libary_app/src/department/domain/entities/department.dart';
import 'package:smart_libary_app/src/department/domain/repository/department_repository.dart';

class DepartmentRepositoryImpl extends DepartmentRepository {
  @override
  Future<DepartmentModel> getDepartments() async {
    String url = '${AppConstant.apiUrl}/department-list';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final books = results.map((e) => Department.fromMap(e)).toList();
      return DepartmentModel(
        departments: books,
        pageNumber: value.data['next'] ?? 0,
        totalCount: value.data['count'],
      );
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
