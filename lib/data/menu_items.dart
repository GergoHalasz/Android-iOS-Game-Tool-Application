import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/model/menu_item.dart';

class MenuItems {
  static const List<MenuItemPopUp> itemsFirst = [
    itemRemoveAds,
    itemRestorePurchases,
    itemLeaveRating,
    itemAbout
  ];

  static const List<MenuItemPopUp> itemsThird = [itemSetGlyphs];

  static const itemSetGlyphs =
      const MenuItemPopUp('Glyphs', Icons.account_balance_wallet);
  static const itemRemoveAds = const MenuItemPopUp('Remove Ads', Icons.block);
  static const itemRestorePurchases =
      const MenuItemPopUp('Restore Purchase', Icons.replay_circle_filled_sharp);
  static const itemLeaveRating =
      const MenuItemPopUp('Leave a Rating!', Icons.rate_review);
       static const itemAbout =
      const MenuItemPopUp('About', Icons.info);
}
