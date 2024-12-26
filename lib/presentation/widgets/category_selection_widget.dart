import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:provider/provider.dart';

class CategorySelectionWidget extends StatefulWidget {
  final List<Category> categories;
  final Category? initialCategory;
  final Function(Category selectedCategory) onCategorySelected;

  const CategorySelectionWidget({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.initialCategory,
  }) : super(key: key);

  @override
  _CategorySelectionWidgetState createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  final TextEditingController _controller = TextEditingController();
  List<Category> filteredCategories = [];
  Category? selectedCategory;
  Category? previousCategory;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    filteredCategories = widget.categories;
    selectedCategory = widget.initialCategory;
    _controller.text = selectedCategory?.name ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (value) {
            selectedCategory = null;
            previousCategory = null;
            Provider.of<VisitDetailProvider>(context, listen: false)
                .setVisitCategory(null);
            setState(() {
              filteredCategories = widget.categories
                  .where((category) =>
                      category.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
          decoration: const InputDecoration(
            hintText: 'type to search Purpose',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        // DropdownButtonFormField<Category>(
        //   items: filteredCategories
        //       .map((category) => DropdownMenuItem(
        //             value: category,
        //             child: Text(category.name),
        //           ))
        //       .toList(),
        //   onChanged: (value) {
        //     if (value != null) {
        //       widget.onCategorySelected(value);
        //       _controller.text = value.name;
        //     }
        //   },
        //   value: filteredCategories.isNotEmpty ? filteredCategories[0] : null,
        // ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          clipBehavior: Clip.hardEdge,
          children: filteredCategories.map((Category category) {
            if (previousCategory == null ||
                category.groupName != previousCategory?.groupName) {
              print(
                  "not match ${previousCategory?.groupName!.toString()} ?? ''");
              previousCategory = category;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    width: MediaQuery.of(context).size.width,
                    color: ColorManager.secondary,
                    child: Text(
                      category.groupName!,
                      style: getMediumStyle(
                          fontColor: ColorManager.white,
                          fontSize: FontSize.mediumLargeSize),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedCategory?.name == category.name
                                  ? ColorManager.secondary
                                  : ColorManager.primary,
                            ),
                            child: Text(
                              category.name,
                              style: TextStyle(
                                  color: selectedCategory?.name == category.name
                                      ? ColorManager.white
                                      : Colors.white,
                                  fontSize: FontSize.mediumLargeSize),
                            )),
                      ),
                      onTap: () {
                        selectedCategory = category;
                        _controller.text = category.name;
                        widget.onCategorySelected(category);
                      }),
                ],
              );
            }
            previousCategory = category;
            return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedCategory?.name == category.name
                            ? ColorManager.secondary
                            : ColorManager.primary,
                      ),
                      child: Text(
                        category.name,
                        style: TextStyle(
                            color: selectedCategory?.name == category.name
                                ? ColorManager.white
                                : Colors.white,
                            fontSize: FontSize.mediumLargeSize),
                      )),
                ),
                onTap: () {
                  selectedCategory = category;
                  _controller.text = category.name;
                  widget.onCategorySelected(category);
                });
          }).toList(),
        ),
      ],
    );
  }
}
