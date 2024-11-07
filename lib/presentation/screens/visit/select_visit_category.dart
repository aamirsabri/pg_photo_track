import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/widgets/category_selection_widget.dart';
import 'package:provider/provider.dart';

class SelectVisitCategoryScreen extends StatefulWidget {
  Category category;
  SelectVisitCategoryScreen({super.key, required this.category});

  @override
  _SelectVisitCategoryScreenState createState() =>
      _SelectVisitCategoryScreenState();
}

class _SelectVisitCategoryScreenState extends State<SelectVisitCategoryScreen> {
  VisitDetailProvider? visitDetailProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      visitDetailProvider =
          Provider.of<VisitDetailProvider>(context, listen: false);
      visitDetailProvider?.fetchCategories();
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

  void onCategorySelected(Category selectedCategory) {
    print('selected category ' + selectedCategory.name);
    final visitDetailProvider =
        Provider.of<VisitDetailProvider>(context, listen: false);
    visitDetailProvider.photos.last.category = selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final visitDetailProvider = Provider.of<VisitDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Select Visit Category")),
      body: visitDetailProvider.isLoading
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
                  CategorySelectionWidget(
                      categories: visitDetailProvider!.categories,
                      onCategorySelected: onCategorySelected),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Next1"),
                  ),
                ],
              ),
            ),
    );
  }
}
