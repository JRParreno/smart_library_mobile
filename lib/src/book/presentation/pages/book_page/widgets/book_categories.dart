import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/core/common_widget/common_btn_chip.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_categories_loading.dart';
import 'package:smart_libary_app/src/department/data/datasources/department_repository_impl.dart';
import 'package:smart_libary_app/src/department/domain/entities/department.dart';
import 'package:smart_libary_app/src/home/presentation/bloc/home_department/home_department_bloc.dart';

class BookCategories extends StatelessWidget {
  const BookCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context).textTheme;
    final homeDepartmentBloc = HomeDepartmentBloc(DepartmentRepositoryImpl());

    return BlocProvider(
      create: (context) => homeDepartmentBloc..add(OnGetHomeDepartmentEvent()),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Categories',
              style: themeContext.titleLarge,
            ),
            BlocBuilder<HomeDepartmentBloc, HomeDepartmentState>(
              builder: (context, state) {
                if (state is HomeDepartmentError) {
                  return const CustomText(text: 'Something went wrong');
                }
                if (state is HomeDepartmentLoaded) {
                  return Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...chipButtons(state.departmentModel.departments)
                        ],
                      ),
                    ),
                  );
                }
                return const BookCategoriesLoading();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> chipButtons(List<Department> data) {
    if (data.length < 10) {
      return data
          .take(10)
          .map((e) => Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: CommonBtnChop(
                    title: e.acronym,
                    onTap: () {
                      // TODO filter home
                    }),
              ))
          .toList();
    }

    return [];
  }
}
