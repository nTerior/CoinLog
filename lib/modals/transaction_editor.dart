import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/limits.dart';
import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/modals/choice_selector.dart';
import 'package:coin_log/morphism/glass_morphism.dart';

import 'package:coin_log/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class TransactionEditorSheet extends StatefulWidget {
  final Transaction? transaction;

  const TransactionEditorSheet({Key? key, this.transaction}) : super(key: key);

  @override
  State<TransactionEditorSheet> createState() => _TransactionEditorSheetState();
}

class _TransactionEditorSheetState extends State<TransactionEditorSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _amountFocusNode = FocusNode();

  late final Transaction? _initialTransaction;

  bool _isExpense = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _initialTransaction = widget.transaction;
    if (_initialTransaction != null) {
      _isExpense = _initialTransaction!.amount < 0;
      _selectedDate = _initialTransaction!.dateTime;
    }
    super.initState();
  }

  void showDateTimePicker() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 100),
    );

    if (date == null) return;

    if (context.mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );
      _selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? date.hour,
        time?.minute ?? date.minute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
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
                      _initialTransaction == null ? "Add " : "Edit ",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
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
                        initialValue: _initialTransaction?.title ?? "",
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
                emptySelectionAllowed: false,
                multiSelectionEnabled: false,
                selected: {_isExpense},
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
                  initialValue:
                      _initialTransaction?.amount.abs().toStringAsFixed(2) ??
                          "",
                ),
              ),
            ],
          ),
          const SizedBox(height: Layout.padding),
          GlassMorphismButton(
            height: 50,
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;
              FocusManager.instance.primaryFocus?.unfocus();

              final amount =
                  double.parse(_formKey.currentState!.fields["amount"]!.value) *
                      (_isExpense ? -1 : 1);

              final exceeded = Limits.willExceedAnyLimit(
                context,
                _initialTransaction != null
                    ? _initialTransaction!.amount - amount
                    : amount,
              );

              if (exceeded.limit != null && amount < 0) {
                final decision = await openModal<bool>(
                  context,
                  ChoiceSelectorModal(
                    text: TextSpan(
                      text: "You are exceeding your ",
                      style: const TextStyle(fontWeight: FontWeight.w100),
                      children: [
                        TextSpan(
                          text: exceeded.limit,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        const TextSpan(text: " by "),
                        TextSpan(
                          text: (-exceeded.remaining).asCurrency("€"),
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        const TextSpan(text: "!"),
                      ],
                    ),
                    choices: [
                      SelectorChoice(
                        name: "Ignore Limit",
                        icon: Symbols.warning,
                        color: Colors.yellow[700],
                        value: true,
                      ),
                      const SelectorChoice(
                        name: "Cancel",
                        icon: Symbols.cancel,
                        value: false,
                      ),
                    ],
                  ),
                );

                if (decision == null || !decision) {
                  return;
                }
              }

              if (_initialTransaction != null) {
                _initialTransaction!
                  ..title = _formKey.currentState!.fields["title"]!.value
                  ..amount = amount
                  ..dateTime = _selectedDate;

                if (context.mounted) {
                  Provider.of<Finance>(context, listen: false)
                      .editTransaction(_initialTransaction!);
                  Navigator.pop(context);
                }
                return;
              }

              final t = Transaction()
                ..title = _formKey.currentState!.fields["title"]!.value
                ..amount = amount
                ..dateTime = _selectedDate;

              if (context.mounted) {
                Provider.of<Finance>(context, listen: false).add(t);
                Navigator.pop(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                Icon(
                  _initialTransaction != null
                      ? Symbols.save
                      : Symbols.add_rounded,
                  weight: 100,
                  size: 40,
                ),
                Text(_initialTransaction != null ? " Save" : " Add"),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: Layout.padding),
        ],
      ),
    );
  }
}
