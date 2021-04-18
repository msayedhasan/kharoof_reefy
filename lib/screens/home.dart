import 'package:flutter/material.dart';
import 'package:kharoof_reefy/collection/categories.dart';
import 'package:kharoof_reefy/models/entites/banner.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/services/api_services.dart';
import 'package:kharoof_reefy/widgets/carousel/carousel_slider_widget.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/home_grid/home_grid_item.dart';
import 'package:kharoof_reefy/widgets/home_grid/home_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    if (allCategories.isEmpty && subCategories.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ApiServices().getCategories().then((value) {
          if (mounted) {
            setState(() {});
          }
        });
      });
    }

    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    allCategories.clear();
    ApiServices().getCategories().then((value) {
      if (mounted) {
        setState(() {});
      }
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xfff6f8ff),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: false,
          isHome: true,
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 0),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        header: WaterDropHeader(),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FutureBuilder<List<BannerModel>>(
                        future: OpenCartApiService().getBanners(),
                        builder: (_ctx, _snapshot) {
                          if (_snapshot.data == null)
                            return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            );
                          return CarouselSliderWidget(
                            images: _snapshot.data
                                .map(
                                  (e) => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        e.image,
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                allCategories.isNotEmpty
                    ? Wrap(
                        children: List.generate(
                          allCategories.length,
                          (index) => HomeGridItem(
                            mainImage: allCategories[index].image,
                            title: allCategories[index].name,
                            hasLink: true,
                            categoryModel: allCategories[index],
                          ),
                        ),
                      )
                    : Wrap(
                        children: List.generate(
                          10,
                          (index) => HomeGridItem(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
