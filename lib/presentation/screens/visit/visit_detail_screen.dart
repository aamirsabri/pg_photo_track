import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/screens/visit/photo_detail_screen.dart';
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
    visitDetailProvider.setDefaultCategory(selectedCategory);
    visitDetailProvider.visitDetail.selectedCategory = selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final visitDetailProvider = Provider.of<VisitDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Visit Details",
        style: getMediumStyle(
            fontColor: ColorManager.white, fontSize: FontSize.mediumLargeSize),
      )),
      body: visitDetailProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: false,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown for category selection
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Purpose',
                        style: getMediumStyle(
                            fontColor: ColorManager.primaryFont,
                            fontSize: FontSize.bigSize),
                      ),
                    ],
                  ),
                  // Text(
                  //   "Visit Identifier (Optional)",
                  //   style: getMediumStyle(
                  //       fontColor: ColorManager.primaryFontOpacity70,
                  //       fontSize: FontSize.mediumSize),
                  // ),
                  // SizedBox(
                  //   height: 4,
                  // ),

                  // TextField(
                  //   decoration: InputDecoration(
                  //       labelText:
                  //           "SR No, Consumer No, Feeder No etc.. if any"),
                  //   onChanged: (value) {
                  //     visitDetailProvider.setVisitLabel(value);
                  //   },
                  // ),
                  // SizedBox(height: 32),
                  // Text(
                  //   "Remark",
                  //   style: getMediumStyle(
                  //       fontColor: ColorManager.primaryFontOpacity70,
                  //       fontSize: FontSize.regularSize),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: TextField(
                  //     keyboardType: TextInputType.multiline,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'Enter Remark',
                  //     ),
                  //     minLines: 3,
                  //     maxLines: 3,
                  //     onChanged: (value) {
                  //       visitDetailProvider.visitDetail.setRemarkd(value);
                  //     },
                  //   ),
                  // ),

                  SizedBox(height: 24),
                  CategorySelectionWidget(
                      categories: visitDetailProvider!.categories,
                      onCategorySelected: onCategorySelected),
                  // TextField for visit label

                  // TextField for visit remarks
                  // TextField(
                  //   decoration: InputDecoration(labelText: "Remarks"),
                  //   maxLines: 5,
                  //   onChanged: (value) {
                  //     visitDetailProvider.setVisitRemarks(value);
                  //   },
                  // ),
                  // Spacer(),

                  // Submit button
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: visitDetailProvider.isFormValid()
              ? () {
                  // Proceed to next screen (e.g., photo capture)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PhotoDetailScreen(
                        category: visitDetailProvider!.defaultCategory!);
                  }));
                }
              : null,
          child: Text(
            "Next - Add Photo Detail",
            style: getMediumStyle(
                fontColor: ColorManager.white,
                fontSize: FontSize.mediumLargeSize),
          ),
        ),
      ),
    );
  }
}
