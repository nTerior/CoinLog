import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({Key? key}) : super(key: key);

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _amountFocusNode = FocusNode();

  bool _isExpense = true;

  DateTime _selectedDate = DateTime.now();

  void showDateTimePicker() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    _selectedDate = DateTime(
      date.year,
      date.month,
      date.day,
      time?.hour ?? date.hour,
      time?.minute ?? date.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      bottomBorderWidth: 0,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(Layout.borderRadius),
        bottom: Radius.zero,
      ),
      padding: Layout.padding.tlrPad,
      child: FormBuilder(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "Add ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
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
                ),
                IconButton(
                  onPressed: showDateTimePicker,
                  icon: Icon(
                    Symbols.calendar_month_rounded,
                    size: 35,
                    weight: 100,
                    color: Colors.white.withOpacity(0.5),
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
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w100,
                        ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.required(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Layout.padding),
            InkWell(
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                Provider.of<Finance>(context, listen: false).add(
                  Transaction(
                    title: _formKey.currentState!.fields["title"]!.value,
                    amount: double.parse(
                            _formKey.currentState!.fields["amount"]!.value) *
                        (_isExpense ? -1 : 1),
                    dateTime: _selectedDate,
                  ),
                );
                Navigator.pop(context);
              },
              child: const GlassMorphism(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    Icon(
                      Symbols.add_rounded,
                      weight: 100,
                      size: 40,
                    ),
                    Text(" Add"),
                    Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Layout.padding),
          ],
        ),
      ),
    );
  }
}
