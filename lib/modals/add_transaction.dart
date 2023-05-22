import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({Key? key}) : super(key: key);

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _amountFocusNode = FocusNode();

  bool _isExpense = true;

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      bottomWidth: 0,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(Layout.borderRadius),
        bottom: Radius.zero,
      ),
      child: Padding(
        padding: Layout.padding.tlrPad,
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "Add ",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w100,
                          color: Colors.white.withOpacity(0.5),
                        ),
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "title",
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                height: 1.5,
                                fontWeight: FontWeight.w100,
                              ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(
                        _amountFocusNode,
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SegmentedButton(
                    segments: const [
                      ButtonSegment(
                        value: false,
                        enabled: true,
                        icon: Icon(
                          Symbols.add,
                          size: 40,
                          weight: 100,
                        ),
                      ),
                      ButtonSegment(
                        value: true,
                        enabled: true,
                        icon: Icon(
                          Symbols.remove,
                          size: 40,
                          weight: 100,
                        ),
                      ),
                    ],
                    showSelectedIcon: false,
                    selected: {_isExpense},
                    emptySelectionAllowed: false,
                    multiSelectionEnabled: false,
                    onSelectionChanged: (p0) =>
                        setState(() => _isExpense = p0.first),
                  ),
                  const SizedBox(width: Layout.padding),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "amount",
                      focusNode: _amountFocusNode,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Amount",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                        ),
                        suffixText: " €",
                      ),
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: FontWeight.w100,
                              ),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.required(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Layout.padding),
            ],
          ),
        ),
      ),
    );
  }
}
