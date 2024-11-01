import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:provider/provider.dart';

class CategorySelectionWidget extends StatefulWidget {
  final List<Category> categories;
  final Function(Category selectedCategory) onCategorySelected;

  const CategorySelectionWidget({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _CategorySelectionWidgetState createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  final TextEditingController _controller = TextEditingController();
  List<Category> filteredCategories = [];
  Category? selectedCategory;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    filteredCategories = widget.categories;
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
            Provider.of<VisitDetailProvider>(context, listen: false)
                .setVisitCategory(null);
            setState(() {
              filteredCategories = widget.categories
                  .where((category) => category.name
                      .toLowerCase()
                      .startsWith(value.toLowerCase()))
                  .toList();
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search Category',
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
        Wrap(
          children: filteredCategories.map((Category category) {
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
                              : Colors.black,
                        ),
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
