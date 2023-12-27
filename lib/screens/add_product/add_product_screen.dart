import 'package:flutter/material.dart';
import 'package:shop_app/screens/add_product/components/body.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../details/components/custom_app_bar.dart';





class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: 5),
      ),

      body: Body(),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.AddProduct),

    );
  }
}
