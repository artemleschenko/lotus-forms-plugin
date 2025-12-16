import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_information_scope.dart';

import '../../domain/domain.dart';
import '../cubit/form_cubit.dart';
import '../cubit/form_state.dart';

class FormsBody extends StatelessWidget {
  const FormsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formInformation = FormInformationScope.of(context);

    return SizedBox(
      child: BlocConsumer<FormCubit, FormState>(
        listener: (context, state) {
          if (state.status == FormStatus.failure && state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          if (state.status == FormStatus.loading && state.schema == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.schema == null) return const SizedBox();

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.schema!.elementForms.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index == state.schema!.elementForms.length) {
                return ElevatedButton(
                  onPressed: () =>
                      context.read<FormCubit>().getForm(formInformation.id),
                  child: state.status == FormStatus.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Отправить"),
                );
              }

              final field = state.schema!.elementForms[index];
              final currentValue = state.values[field.id];

              return _buildFieldWidget(context, field, currentValue);
            },
          );
        },
      ),
    );
  }

  Widget _buildFieldWidget(
    BuildContext context,
    FormElementEntity field,
    dynamic currentValue,
  ) {
    switch (field.type) {
      case FieldType.text:
        return TextFormField(
          initialValue: currentValue as String?,
          decoration: InputDecoration(
            labelText: field.header,
            hintText: field.config.placeholder,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            // context.read<FormCubit>().fieldChanged(field.id, value);
          },
        );

      case FieldType.dropdown:
        return DropdownButtonFormField<String>(
          initialValue: currentValue as String?,
          decoration: InputDecoration(
            labelText: field.header,
            border: const OutlineInputBorder(),
          ),
          items: field.config.options.map((opt) {
            return DropdownMenuItem(
              value: opt.value,
              child: Text(opt.displayText),
            );
          }).toList(),
          onChanged: (value) {
            // context.read<FormCubit>().fieldChanged(field.id, value);
          },
        );

      case FieldType.file:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(field.header, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement file picker logic
                },
                icon: const Icon(Icons.upload_file),
                label: const Text("Выбрать файл"),
              ),
            ],
          ),
        );

      default:
        return Text("Неизвестный тип поля: ${field.type}");
    }
  }
}
