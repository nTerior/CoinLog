import 'package:flutter/material.dart';

extension LayoutUtils on double {
  get br => BorderRadius.circular(this);

  get pad => EdgeInsets.all(this);
  get hPad => EdgeInsets.symmetric(horizontal: this);
  get vPad => EdgeInsets.symmetric(vertical: this);
  get tPad => EdgeInsets.only(top: this);
  get bPad => EdgeInsets.only(bottom: this);
  get lPad => EdgeInsets.only(left: this);
  get rPad => EdgeInsets.only(right: this);

  get tlrPad => EdgeInsets.only(top: this, left: this, right: this);
  get blrPad => EdgeInsets.only(bottom: this, left: this, right: this);
}

class Layout {
  Layout._();

  static const double padding = 16;
  static const double borderRadius = 16;
}
