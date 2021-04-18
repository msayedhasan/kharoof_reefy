class CategoryModel {
  String name;
  String image;
  String price;
  String id;
  String parentID;
  String countProducts;
  bool hasSubCategory;
  CategoryModel(
      {this.name,
      this.image,
      this.price,
      this.id,
      this.parentID,
      this.countProducts,
      this.hasSubCategory});
}
