import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_application/providers/product_provider.dart';
import 'package:super_market_application/shared/app_bar.dart';
import 'package:super_market_application/shared/constants.dart';
import 'package:super_market_application/shared/product_list.dart';
import 'package:super_market_application/shared/side_menu_bar.dart';

// ignore: must_be_immutable
class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);
  dynamic arguments;

  @override
  Widget build(BuildContext context) {
    this.arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int NF = Provider.of<ProductProviders>(context, listen: false)
        .getCatProductCount(this.arguments['categoryName']);
    return Scaffold(
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TopBar('${arguments['categoryName']}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Consumer<ProductProviders>(
                  builder: (context, ProductProviders data, child) {
                    return NF != 0
                        ? ListView.builder(
                            itemCount: data.getProduct.length,
                            itemBuilder: (context, index) {
                              return ProductItem(data.getProduct[index], index);
                            },
                          )
                        : Center(
                            child: Text(
                              'No Available Products in ${arguments['categoryName']}',
                              style: TextStyle(
                                color: green,
                                fontSize: fontSizeH,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
