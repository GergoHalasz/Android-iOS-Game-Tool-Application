import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/model/menu_item.dart';

class MenuItems {
  static const List<MenuItemPopUp> itemsFirst = [
    itemResetTree,
    itemLeaveRating,
  ];

  static const List<MenuItemPopUp> itemsThird = [itemSetGlyphs];


  static const itemResetTree = const MenuItemPopUp('Reset Tree', Icons.refresh);

  static const itemSetGlyphs =
      const MenuItemPopUp('Glyphs', Icons.account_balance_wallet);

  static const itemLeaveRating =
      const MenuItemPopUp('Leave a Rating!', Icons.rate_review);


}
