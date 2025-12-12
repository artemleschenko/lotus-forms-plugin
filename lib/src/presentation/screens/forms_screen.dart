import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lotus_forms_package/src/core/di/app_di.dart';
import 'package:lotus_forms_package/src/presentation/cubit/form_cubit.dart';

import '../presentation.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormCubit(
        getFormUseCase: appLocator(),
        saveFormUseCase: appLocator(),
      ),
      child: const FormsBody(),
    );
  }
}
