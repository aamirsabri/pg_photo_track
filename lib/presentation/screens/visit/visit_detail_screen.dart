import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    final visitDetailProvider = Provider.of<VisitDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Visit Details")),
      body: visitDetailProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown for category selection
                  TextField(
                    decoration: InputDecoration(
                        labelText:
                            "SR No, Consumer No, Feeder No etc.. if any"),
                    onChanged: (value) {
                      visitDetailProvider.setVisitLabel(value);
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButton<Category>(
                    isExpanded: true,
                    value: visitDetailProvider.visitDetail.selectedCategory,
                    hint: Text("Select a category"),
                    items:
                        visitDetailProvider.categories.map((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (Category? newValue) {
                      visitDetailProvider.setVisitCategory(newValue);
                    },
                  ),
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
                  ElevatedButton(
                    onPressed: true
                        // visitDetailProvider.isFormValid()
                        ? () {
                            // Proceed to next screen (e.g., photo capture)
                            Navigator.pushNamed(context, Routes.capturePhoto);
                          }
                        : null,
                    child: Text("Next"),
                  ),
                ],
              ),
            ),
    );
  }
}
