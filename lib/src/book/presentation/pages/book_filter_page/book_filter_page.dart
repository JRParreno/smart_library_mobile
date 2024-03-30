import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/book/data/models/semester_model.dart';
import 'package:smart_libary_app/src/book/data/models/year_level_model.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_book/search_book_bloc.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_filter/search_filter_cubit.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_filter_page/widgets/filter_information.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_filter_page/widgets/rate_filter.dart';
import 'package:toggle_list/toggle_list.dart';

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
  bool isShowRating = true;

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
      appBar: buildAppBar(context: context, title: 'Book Filter(s)', actions: [
        InkWell(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const CustomText(text: AppConstant.appName),
              content: const Text('Clear all filters?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const CustomText(text: 'Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    searchFilterCubit.onResetFilters();
                    setState(() {
                      bookFilterModel = searchFilterCubit.state;
                    });
                    onResetFilter();
                    Navigator.of(context).pop();
                  },
                  child: const CustomText(
                    text: 'OK',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.filter_alt_off,
              color: Colors.white,
            ),
          ),
        ),
      ]),
      body: CustomContainer(
        child: BlocBuilder<SearchFilterCubit, BookFilterModel>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FilterInformation(),
                  const Gap(20),
                  RateFilter(
                    isShow: isShowRating,
                    rate: state.rate,
                    onChange: (value) {
                      setState(() {
                        bookFilterModel = bookFilterModel.copyWith(
                          rate: value,
                        );
                      });
                    },
                  ),
                  const Divider(
                    color: ColorName.primary,
                    thickness: 0.5,
                  ),
                  const Gap(10),
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
                  const Gap(10),
                  ToggleList(
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ToggleListItem(
                        title: const CustomText(
                          text: 'Departments',
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              state.departments.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          bookFilterModel.departments.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final item =
                                            bookFilterModel.departments[index];

                                        return CheckboxListTile(
                                          visualDensity: VisualDensity.compact,
                                          enableFeedback: true,
                                          tileColor: Colors.red,
                                          title: CustomText(
                                              text: item.department.name),
                                          value: item.isEnable,
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
                              if (bookFilterModel.departments
                                  .where((element) => element.isEnable)
                                  .isNotEmpty) ...[
                                InkWell(
                                  onTap: () {
                                    onChangeValue(field: 'departments');
                                  },
                                  child: const Text(
                                    'Clear All',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      ToggleListItem(
                        title: const Text('Year Levels'),
                        content: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              state.yearLevels.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          bookFilterModel.yearLevels.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final item =
                                            bookFilterModel.yearLevels[index];

                                        return CheckboxListTile(
                                          visualDensity: VisualDensity.compact,
                                          enableFeedback: true,
                                          tileColor: Colors.red,
                                          title:
                                              CustomText(text: item.yearLevel),
                                          value: item.isEnable,
                                          onChanged: (bool? value) {
                                            onChangeValue(
                                              field: 'yearLevels',
                                              index: index,
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : const CircularProgressIndicator(),
                              if (bookFilterModel.yearLevels
                                  .where((element) => element.isEnable)
                                  .isNotEmpty) ...[
                                InkWell(
                                  onTap: () {
                                    onChangeValue(field: 'yearLevels');
                                  },
                                  child: const Text(
                                    'Clear All',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      ToggleListItem(
                        title: const Text('Semester'),
                        content: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              state.semesters.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          bookFilterModel.semesters.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final item =
                                            bookFilterModel.semesters[index];

                                        return CheckboxListTile(
                                          visualDensity: VisualDensity.compact,
                                          enableFeedback: true,
                                          tileColor: Colors.red,
                                          title:
                                              CustomText(text: item.semester),
                                          value: item.isEnable,
                                          onChanged: (bool? value) {
                                            onChangeValue(
                                              field: 'semesters',
                                              index: index,
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : const CircularProgressIndicator(),
                              if (bookFilterModel.semesters
                                  .where((element) => element.isEnable)
                                  .isNotEmpty) ...[
                                InkWell(
                                  onTap: () {
                                    onChangeValue(field: 'semesters');
                                  },
                                  child: const Text(
                                    'Clear All',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
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
                  ),
                  const Gap(25),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> onResetFilter() async {
    setState(() {
      isShowRating = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isShowRating = true;
      });
    });
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
            department: department.department,
          );

          setState(() {
            bookFilterModel =
                bookFilterModel.copyWith(departments: [...deparments]);
          });
          return;
        }
        setState(() {
          bookFilterModel = bookFilterModel.copyWith(
            departments: bookFilterModel.departments
                .map((e) => e.copyWith(isEnable: false))
                .toList(),
          );
        });
        break;
      case 'yearlevels':
        if (index > -1) {
          final yearLevels = [...bookFilterModel.yearLevels];
          final yearLevel = yearLevels[index];
          yearLevels[index] = YearLevelModel(
            isEnable: !yearLevel.isEnable,
            yearLevel: yearLevel.yearLevel,
            value: yearLevel.value,
          );

          setState(() {
            bookFilterModel =
                bookFilterModel.copyWith(yearLevels: [...yearLevels]);
          });
          return;
        }
        setState(() {
          bookFilterModel = bookFilterModel.copyWith(
            yearLevels: bookFilterModel.yearLevels
                .map((e) => e.copyWith(isEnable: false))
                .toList(),
          );
        });
        break;
      case 'semesters':
        if (index > -1) {
          final semesters = [...bookFilterModel.semesters];
          final semester = semesters[index];
          semesters[index] = SemesterModel(
            isEnable: !semester.isEnable,
            semester: semester.semester,
            value: semester.value,
          );

          setState(() {
            bookFilterModel =
                bookFilterModel.copyWith(semesters: [...semesters]);
          });
          return;
        }
        setState(() {
          bookFilterModel = bookFilterModel.copyWith(
            semesters: bookFilterModel.semesters
                .map((e) => e.copyWith(isEnable: false))
                .toList(),
          );
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
