import 'package:flutter/material.dart';
import 'package:kharoof_reefy/models/option_value_model.dart';
import 'package:kharoof_reefy/models/options_model.dart';
import 'package:kharoof_reefy/models/productModel.dart';
import 'package:kharoof_reefy/services/api_services.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/products/products_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class Products extends StatefulWidget {
  final String categoryName;
  final String categoryID;
  Products({Key key, @required this.categoryName, @required this.categoryID})
      : super(key: key);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    fetchProducts();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  List<ProductModel> productList = [];
  bool _isLoading = false;
  Future fetchProducts() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      print(widget.categoryID);
      await ApiServices().getProducts(widget.categoryID).then((response) {
        for (var item in response) {
          ProductModel productModel = ProductModel(
              id: item['id'],
              name: item['name'],
              image: item['image'],
              priceInt: item['price'],
              priceString: item['price_formated'],
              description: item['description'],
              options: []);
          item['options'].forEach((k, v) {
            OptionModel optionModel = OptionModel(
              id: int.parse(k),
              name: v['name'],
              type: v['type'],
              required: v['required'] == '1' ? true : false,
              optionValue: [],
            );
            for (var singleValue in v['option_value']) {
              print(v['option_value']);
              OptionValueModel optionValueModel = OptionValueModel(
                priceInt: singleValue['price_excluding_tax'],
                priceString: singleValue['price_formated'],
                id: singleValue['option_value_id'],
                name: singleValue['name'],
                prefix: singleValue['price_prefix'],
              );
              optionModel.optionValue.add(optionValueModel);
            }
            productModel.options.add(optionModel);
          });
          productList.add(productModel);
        }
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (err) {
      print(err);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f8ff),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            isHome: false,
            hasBack: true,
            categoryName: widget.categoryName,
          )),
      // bottomNavigationBar: CustomBottomBar(index: 0,),
      // body: Container()
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        header: WaterDropHeader(),
        child: _isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    10,
                    (index) => Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : productList.length > 0
                ? ProductList(
                    allProducts: productList,
                  )
                : Center(
                    child: Text('لا يوجد منتجات'),
                  ),
      ),
    );
  }
}
