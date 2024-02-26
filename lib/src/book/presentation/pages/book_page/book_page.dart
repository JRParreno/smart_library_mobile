import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/src/book/data/datasources/book_repository_impl.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_categories.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_section.dart';
import 'package:smart_libary_app/src/home/presentation/bloc/home_book/home_book_bloc.dart';

class BookPage extends StatefulWidget {
  static const String routeName = '/book';
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late HomeBookBloc homeBookBloc;

  @override
  void initState() {
    super.initState();

    homeBookBloc = HomeBookBloc(BookRepositoryImpl());

    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBookBloc..add(OnGetHomeBookEvent()),
      child: Flex(
        direction: Axis.vertical,
        children: [
          const BookCategories(),
          const Gap(25),
          BookSection(
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        homeBookBloc.add(OnPaginateHoomBookEvent());
      }
    });
  }
}
