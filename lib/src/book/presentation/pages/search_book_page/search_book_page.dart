import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/custom_text.dart';
import 'package:smart_libary_app/core/widgets/custom_widgets.dart';
import 'package:smart_libary_app/src/book/data/datasources/book_repository_impl.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_book/search_book_bloc.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list_loading.dart';

class SearchBookPage extends StatefulWidget {
  static const String routeName = '/book/search';
  const SearchBookPage({super.key});

  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  final TextEditingController searchCtrl = TextEditingController();

  final ScrollController scrollController = ScrollController();
  late SearchBookBloc searchBookBloc;

  @override
  void initState() {
    super.initState();

    searchBookBloc = SearchBookBloc(BookRepositoryImpl());
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBookBloc,
      child: Column(
        children: [
          CustomTextField(
            onSubmitted: (value) {
              if (value != null && value.isNotEmpty) {
                searchBookBloc.add(OnGetSearchBookEvent(value));
              }
            },
            controller: searchCtrl,
            hintText: 'Search...',
          ),
          const Gap(10),
          Expanded(
            child: BlocBuilder<SearchBookBloc, SearchBookState>(
              builder: (context, state) {
                if (state is SearchBookError) {
                  return const SizedBox(
                      width: double.infinity,
                      child: CustomText(text: 'Something went wrong'));
                }
                if (state is SearchBookLoaded) {
                  if (state.bookModel.books.isEmpty) {
                    return const Center(
                      child: CustomText(
                          text: 'Book not found, try different keyword'),
                    );
                  }
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: BookList(
                      books: state.bookModel.books,
                      isPaginate: state.isPaginate,
                    ),
                  );
                }
                if (state is SearchBookInitial) {
                  return const SizedBox();
                }
                return const BookListLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        searchBookBloc.add(OnPaginateSearchBookEvent());
      }
    });
  }
}
