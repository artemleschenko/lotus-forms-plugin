import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core_ui/core_ui.dart';
import '../cubit/form_cubit.dart';

class FormsBody extends StatelessWidget {
  const FormsBody({super.key});

  @override
  Widget build(BuildContext context) {
    // FIXME: Change this to real forms
    // Change state watching
    final form = context.watch<FormCubit>().state.form;
    final isLoading = context.watch<FormCubit>().state.isLoading;
    final error = context.watch<FormCubit>().state.error;

    return Container(
      color: AppColors.of(context).primaryBg,
      child: ListView(
        shrinkWrap: true,
        children: [
          if (isLoading) const CircularProgressIndicator(),
          if (error.isNotEmpty) Text(error),
          if (!isLoading && error.isEmpty) Text(form.name),
        ],
      ),
    );
  }
}
