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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.primary,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add your app icon here
                  Image.asset(
                    'assets/images/pgvclicon.jpg',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text('FIELD PHOTO PGVCL',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: Text(
              'View Photos',
              style: getMediumStyle(
                  fontColor: ColorManager.darkgrey,
                  fontSize: FontSize.mediumLargeSize),
            ),
            onTap: () {
              // Handle view photos action
              // _scaffoldKey.currentState!.closeDrawer();
              Navigator.pushNamed(context, Routes.viewPhotos);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'Logout',
              style: getMediumStyle(
                  fontColor: ColorManager.darkgrey,
                  fontSize: FontSize.mediumLargeSize),
            ),
            onTap: () {
              // Handle logout action
              // Implement your logout logic here
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visitDetailProvider = Provider.of<VisitDetailProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Visit Details",
          style: getMediumStyle(
              fontColor: ColorManager.white,
              fontSize: FontSize.mediumLargeSize),
        ),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.settings)),
      ),
      drawer: buildDrawer(),
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

                  const SizedBox(height: 24),
                  CategorySelectionWidget(
                      categories: visitDetailProvider!.categories,
                      onCategorySelected: onCategorySelected),
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
