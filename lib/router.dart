import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/features/address/screens/address_screen.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/auth/screens/auth_screens.dart';
import 'package:amazon/features/home/screens/category_deals_screen.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreens(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomBar(),
        settings: routeSettings,
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
        settings: routeSettings,
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(category: category),
          settings: routeSettings);
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
        settings: routeSettings,
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: product),
        settings: routeSettings,
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Page Not Found"),
          ),
        ),
      );
  }
}
