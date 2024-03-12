import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rate/rate.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/book_detail/book_detail_bloc.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/book_detail/rate/book_rate_cubit.dart';

class RateBottomModal {
  static void showModal({
    required BuildContext context,
    required BookRateCubit bookRateCubit,
    required BookDetailBloc bookDetailBloc,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<BookRateCubit, BookRateState>(
          bloc: bookRateCubit,
          builder: (context, state) {
            return Container(
              height: 250,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const CustomText(
                          text: 'Rate this book',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const Gap(15),
                        Rate(
                          iconSize: 55,
                          color: ColorName.primary,
                          allowHalf: false,
                          allowClear: true,
                          initialValue: state.initialRate,
                          onChange: (value) {
                            bookRateCubit.onChangedRate(value);
                          },
                        ),
                        const Gap(15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: CustomBtn(
                            label: 'Save',
                            onTap: state.initialRate != state.modifiedRate
                                ? () {
                                    bookDetailBloc.add(
                                        OnRateBookEvent(state.modifiedRate));
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      Navigator.pop(context);
                                    });
                                  }
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
