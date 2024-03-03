import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_book/search_book_bloc.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_filter/search_filter_cubit.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_filter_page/widgets/filter_information.dart';

class BookFilterArgs {
  final String search;
  BookFilterArgs({
    required this.search,
  });
}

class BookFilterPage extends StatefulWidget {
  static const String routeName = '/book/filter';
  final BookFilterArgs args;

  const BookFilterPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<BookFilterPage> createState() => _BookFilterPageState();
}

class _BookFilterPageState extends State<BookFilterPage> {
  late SearchFilterCubit searchFilterCubit;
  late BookFilterModel bookFilterModel;

  @override
  void initState() {
    super.initState();
    searchFilterCubit = context.read<SearchFilterCubit>();
    searchFilterCubit.onGetCategories();

    bookFilterModel = searchFilterCubit.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(context: context, title: 'Book Filter(s)'),
      body: CustomContainer(
        child: BlocBuilder<SearchFilterCubit, BookFilterModel>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FilterInformation(),
                  const Gap(20),
                  const CustomText(
                    text: 'Include(s)',
                    style: TextStyle(
                      color: ColorName.placeHolder,
                    ),
                  ),
                  CheckboxListTile(
                    visualDensity: VisualDensity.compact,
                    enableFeedback: true,
                    activeColor: ColorName.primary,
                    title: const CustomText(text: 'Title'),
                    value: bookFilterModel.isTitle,
                    onChanged: (bool? value) {
                      onChangeValue(field: 'title');
                    },
                  ),
                  CheckboxListTile(
                    visualDensity: VisualDensity.compact,
                    activeColor: ColorName.primary,
                    enableFeedback: true,
                    title: const CustomText(text: 'Author'),
                    value: bookFilterModel.isAuthor,
                    onChanged: (bool? value) {
                      onChangeValue(field: 'author');
                    },
                  ),
                  CheckboxListTile(
                    visualDensity: VisualDensity.compact,
                    activeColor: ColorName.primary,
                    enableFeedback: true,
                    title: const CustomText(text: 'Publisher'),
                    value: bookFilterModel.isPublisher,
                    onChanged: (bool? value) {
                      onChangeValue(field: 'publisher');
                    },
                  ),
                  CheckboxListTile(
                    visualDensity: VisualDensity.compact,
                    activeColor: ColorName.primary,
                    enableFeedback: true,
                    title: const CustomText(text: 'ISSN/ISBN'),
                    value: bookFilterModel.isIssnIsbn,
                    onChanged: (bool? value) {
                      onChangeValue(field: 'issn_isbn');
                    },
                  ),
                  CheckboxListTile(
                    visualDensity: VisualDensity.compact,
                    enableFeedback: true,
                    activeColor: ColorName.primary,
                    title: const CustomText(text: 'Subjects/Tags'),
                    value: bookFilterModel.isSubjects,
                    onChanged: (bool? value) {
                      onChangeValue(field: 'tags');
                    },
                  ),
                  Column(
                    children: [
                      CheckboxListTile(
                        visualDensity: VisualDensity.compact,
                        enableFeedback: true,
                        activeColor: ColorName.primary,
                        title: const Text('Deparments'),
                        value: bookFilterModel.isDepartment,
                        onChanged: (bool? value) {
                          onChangeValue(field: 'departments');
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: state.departments.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: bookFilterModel.departments.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final item =
                                      bookFilterModel.departments[index];

                                  return CheckboxListTile(
                                    visualDensity: VisualDensity.compact,
                                    enabled: bookFilterModel.isDepartment,
                                    enableFeedback: true,
                                    tileColor: Colors.red,
                                    title:
                                        CustomText(text: item.department.name),
                                    value: item.isEnable &&
                                        bookFilterModel.isDepartment,
                                    onChanged: (bool? value) {
                                      onChangeValue(
                                        field: 'departments',
                                        index: index,
                                      );
                                    },
                                  );
                                },
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                  CustomBtn(
                    label: 'Apply Filter',
                    onTap: () {
                      searchFilterCubit.onApplyFilter(bookFilterModel);
                      BlocProvider.of<SearchBookBloc>(context).add(
                          OnGetSearchBookEvent(
                              search: widget.args.search,
                              filters: bookFilterModel));
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void onChangeValue({required String field, int index = -1}) {
    switch (field.toLowerCase()) {
      case 'author':
        setState(() {
          bookFilterModel =
              bookFilterModel.copyWith(isAuthor: !bookFilterModel.isAuthor);
        });
        break;
      case 'title':
        setState(() {
          bookFilterModel =
              bookFilterModel.copyWith(isTitle: !bookFilterModel.isTitle);
        });
        break;
      case 'publisher':
        setState(() {
          bookFilterModel = bookFilterModel.copyWith(
              isPublisher: !bookFilterModel.isPublisher);
        });
        break;
      case 'tags':
        setState(() {
          bookFilterModel =
              bookFilterModel.copyWith(isSubjects: !bookFilterModel.isSubjects);
        });
        break;

      case 'departments':
        if (index > -1) {
          final deparments = [...bookFilterModel.departments];
          final department = deparments[index];
          deparments[index] = DepartmentFilterModel(
              isEnable: !department.isEnable,
              department: department.department);

          setState(() {
            bookFilterModel =
                bookFilterModel.copyWith(departments: [...deparments]);
          });
          return;
        }
        setState(() {
          bookFilterModel = bookFilterModel.copyWith(
              isDepartment: !bookFilterModel.isDepartment);
        });
        break;

      default:
        setState(() {
          bookFilterModel =
              bookFilterModel.copyWith(isIssnIsbn: !bookFilterModel.isIssnIsbn);
        });
        break;
    }
  }
}
