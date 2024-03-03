import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/resources/theme/theme.dart';
import 'package:smart_libary_app/core/routes/routes.dart';
import 'package:smart_libary_app/src/account/data/datasources/profile_repository_impl.dart';
import 'package:smart_libary_app/src/book/data/datasources/book_repository_impl.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_book/search_book_bloc.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/search_filter/search_filter_cubit.dart';
import 'package:smart_libary_app/src/department/data/datasources/department_repository_impl.dart';
import 'package:smart_libary_app/src/home/presentation/home.dart';

class SmartLibaryApp extends StatefulWidget {
  const SmartLibaryApp({super.key});
  static final navKey = GlobalKey<NavigatorState>();

  @override
  State<SmartLibaryApp> createState() => _SmartLibaryAppState();
}

class _SmartLibaryAppState extends State<SmartLibaryApp> {
  bool isNeedOnBoarded = true;
  final ProfileBloc profileBloc = ProfileBloc(ProfileRepositoryImpl());
  final SearchFilterCubit searchFilterCubit =
      SearchFilterCubit(DepartmentRepositoryImpl());
  final SearchBookBloc searchBookBloc = SearchBookBloc(BookRepositoryImpl());

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => profileBloc..add(SetProfileEvent()),
        ),
        BlocProvider(
          create: (context) => searchFilterCubit,
        ),
        BlocProvider(
          create: (context) => searchBookBloc,
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: ((context, child) {
          return MaterialApp(
            navigatorKey: SmartLibaryApp.navKey,
            themeMode: ThemeMode.light,
            darkTheme: MaterialAppThemes.lightTheme,
            theme: MaterialAppThemes.lightTheme,
            onGenerateRoute: generateRoute,
            home: const HomePage(),
          );
        }),
      ),
    );
  }
}
