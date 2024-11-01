import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/category_selection_widget.dart';
import 'package:provider/provider.dart';

class VisitDetailScreen extends StatefulWidget {
  @override
  _VisitDetailScreenState createState() => _VisitDetailScreenState();
}

class _VisitDetailScreenState extends State<VisitDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final visitDetailProvider =
          Provider.of<VisitDetailProvider>(context, listen: false);
      visitDetailProvider.fetchCategories();
    });
  }

  void onCategorySelected(Category selectedCategory) {
    final visitDetailProvider =
        Provider.of<VisitDetailProvider>(context, listen: false);
    visitDetailProvider.setVisitCategory(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final visitDetailProvider = Provider.of<VisitDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Visit Details")),
      body: visitDetailProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: false,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown for category selection
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Visit Identifier",
                    style: getMediumStyle(
                        fontColor: ColorManager.primaryFontOpacity70,
                        fontSize: FontSize.mediumSize),
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  TextField(
                    decoration: InputDecoration(
                        labelText:
                            "SR No, Consumer No, Feeder No etc.. if any"),
                    onChanged: (value) {
                      visitDetailProvider.setVisitLabel(value);
                    },
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Search Category",
                    style: getMediumStyle(
                        fontColor: ColorManager.primaryFontOpacity70,
                        fontSize: FontSize.mediumSize),
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  // TextField(
                  //   decoration:
                  //       InputDecoration(labelText: "Type category name"),
                  //   onChanged: (value) {
                  //     visitDetailProvider.setVisitLabel(value);
                  //   },
                  // ),
                  CategorySelectionWidget(
                      categories: visitDetailProvider.categories,
                      onCategorySelected: onCategorySelected),

                  // DropdownButton<Category>(
                  //   isExpanded: true,
                  //   value: visitDetailProvider.visitDetail.selectedCategory,
                  //   hint: Text("Select a category"),
                  //   items:
                  //       visitDetailProvider.categories.map((Category category) {
                  //     return DropdownMenuItem<Category>(
                  //       value: category,
                  //       child: Text(category.name),
                  //     );
                  //   }).toList(),
                  //   onChanged: (Category? newValue) {
                  //     visitDetailProvider.setVisitCategory(newValue);
                  //   },
                  // ),

                  // Wrap(
                  //   children:
                  //       visitDetailProvider.categories.map((Category category) {
                  //     return Padding(
                  //       padding: EdgeInsets.all(8),
                  //       child: Container(
                  //           padding: EdgeInsets.all(8),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             color: ColorManager.primary,
                  //           ),
                  //           child: Text(category.name)),
                  //     );
                  //   }).toList(),
                  // ),
                  SizedBox(height: 16),

                  // TextField for visit label

                  // TextField for visit remarks
                  // TextField(
                  //   decoration: InputDecoration(labelText: "Remarks"),
                  //   maxLines: 5,
                  //   onChanged: (value) {
                  //     visitDetailProvider.setVisitRemarks(value);
                  //   },
                  // ),
                  Spacer(),

                  // Submit button
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: visitDetailProvider.isFormValid()
              ? () {
                  // Proceed to next screen (e.g., photo capture)
                  Navigator.pushNamed(context, Routes.reviewPhotos);
                }
              : null,
          child: Text(
            "Next",
            style: getMediumStyle(
                fontColor: ColorManager.white, fontSize: FontSize.mediumSize),
          ),
        ),
      ),
    );
  }
}
