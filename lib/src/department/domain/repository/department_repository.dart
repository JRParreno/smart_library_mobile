import 'package:smart_libary_app/src/department/data/models/department_model.dart';

abstract class DepartmentRepository {
  Future<DepartmentModel> getDepartments();
}
