import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/category_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:provider/provider.dart';

class SelectVisitCategoryScreen extends StatefulWidget {
  @override
  _SelectVisitCategoryScreenState createState() =>
      _SelectVisitCategoryScreenState();
}

class _SelectVisitCategoryScreenState extends State<SelectVisitCategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.fetchCategories();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // final categoryProvider =
    //     Provider.of<CategoryProvider>(context, listen: false);
    // categoryProvider.fetchCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Select Visit Category")),
      body: categoryProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // DropdownButton<Category>(
                  //   isExpanded: true,
                  //   value: categoryProvider.selectedCategory,
                  //   hint: Text("Select a category"),
                  //   items: categoryProvider.categories.map((Category category) {
                  //     return DropdownMenuItem<Category>(
                  //       value: category,
                  //       child: Text(category.name),
                  //     );
                  //   }).toList(),
                  //   onChanged: (Category? newValue) {
                  //     print('new value');
                  //     print(newValue!.name);
                  //     categoryProvider.selectCategory(newValue);
                  //   },
                  // ),
                  Wrap(
                    children:
                        categoryProvider.categories.map((Category category) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(category.name),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: categoryProvider.selectedCategory != null
                        ? () {
                            // Navigate to the next screen
                          }
                        : null,
                    child: Text("Next1"),
                  ),
                ],
              ),
            ),
    );
  }
}
