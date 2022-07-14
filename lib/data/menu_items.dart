import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/model/menu_item.dart';

class MenuItems {
  static const List<MenuItemPopUp> itemsFirst = [
    itemResetTree,
    itemResetTrees
  ];

  static const List<MenuItemPopUp> itemsSecond = [
    itemSetGlyphs
  ];

  static const List<MenuItemPopUp> itemsThird = [
    itemShareBuild
  ];

  static const itemResetTree = const MenuItemPopUp('Reset tree', Icons.refresh);
  static const itemResetTrees = const MenuItemPopUp('Reset trees', Icons.refresh);

  static const itemSetGlyphs = const MenuItemPopUp('Set Glyphs', Icons.account_balance_wallet);

  static const itemShareBuild = const MenuItemPopUp('Share Build', Icons.share);
}