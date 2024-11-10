import 'package:flutter/material.dart';
import 'package:skmecom/component/custom_btn.dart';
import 'package:skmecom/component/product_item.dart';
import 'package:skmecom/component/section_heading.dart';
import 'package:skmecom/model/category_model.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/screens/home_navigation.dart';
import 'package:skmecom/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PocketBaseService pocketBaseService = PocketBaseService();
  List<Product> result = [];
  List<CategoryModel> categories = [];

  Future<void> fetchFeaturedProducts() async {
    final productsJson = await pocketBaseService.productsFeatured(
      collectionName: 'products',
    );
    setState(() {
      result = productsJson.map((json) => Product.fromJson(json)).toList();
      //  result = productsJson.cast<Product>();
    });
    print("Featured products: ${result.length}");
    print("Featured products: ${result.first.images}");
  }

  Future<void> fetchCategories() async {
    final categoriesJson = await pocketBaseService.fetchCategories();

    setState(() {
      categories =
          categoriesJson.map((cat) => CategoryModel.fromJson(cat)).toList();
    });
    print("cat: $categories");
  }

  @override
  void initState() {
    super.initState();
    fetchFeaturedProducts();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(198, 236, 233, 233),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage("assets/images/cover-cake.jpg"),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bring your happiness through a piece of cake",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppColors.primarycolor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),

              const SectionHeading(title: "FEATURED"),

              ListView.separated(
                  shrinkWrap:
                      true, // Allows the ListView to size itself correctly
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      productData: result[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemCount: result.length),

              const SizedBox(
                height: 25,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    title: "See More",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNavigation(selectedIndex: 1,)));
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const SectionHeading(title: "CATEGORIES"),

              Container(
                height: 250,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GridTile(
                          // footer:  Text(),
                          child: Image.network(
                        //  "assets/images/category1.webp",
                        "https://commerce.sketchmonk.com/_pb/api/files/${categories[index].collectionId}/${categories[index].id}/${categories[index].image.toString()}",

                        fit: BoxFit.cover,
                      )),
                    );
                  },
                ),
              ),
              //  const SizedBox(
              //   height: 10,
              // ),

               Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(title: "See More",  onPressed: () {}),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
