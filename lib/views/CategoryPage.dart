import 'package:flutter/material.dart';
import 'package:product_app/model/Category.dart';
import 'package:product_app/model_view/Category_ViewModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CategoryViewModel _viewModel = CategoryViewModel();
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    print("initState called");
    _loadCategories(); // 🔥 Call API when widget is initialized
  }

  Future<void> _loadCategories() async {
    try {
      final data = await _viewModel.getCategory();
      setState(() {
        print("_loadCategories called : 1");
        _categories = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        print("_loadCategories called : 2");
        _error = e.toString();
        _isLoading = false;
      });
    }
  }
  
  @override
@override
Widget build(BuildContext context) {
  if (_isLoading) return const Center(child: CircularProgressIndicator());
  if (_error != null) return Center(child: Text('Error: $_error'));

  return Scaffold(
    backgroundColor: Colors.purpleAccent,
    body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.purpleAccent,
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Photos from API',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  
                ),
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: List.generate(_categories.length, (index) {
                  final category = _categories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              category.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${category.id}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


// Widget build(BuildContext context) {
//   if (_isLoading) return const Center(child: CircularProgressIndicator());
//   if (_error != null) return Center(child: Text('Error: $_error'));

//   return Container(
//     color: Colors.purpleAccent, // Background color
//     child: ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _categories.length,
//       itemBuilder: (context, index) {
//         final category = _categories[index];
//         return Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           margin: const EdgeInsets.only(bottom: 16),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     category.image,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) =>
//                         const Icon(Icons.broken_image, size: 100),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('${category.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 4),
//                       Text(category.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chevron_right),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Categories")),
  //     body: Builder(
  //       builder: (context) {
  //         if (_isLoading)
  //           return const Center(child: CircularProgressIndicator());
  //         if (_error != null) return Center(child: Text('Error: $_error'));

  //         return ListView.builder(
  //           itemCount: _categories.length,
  //           itemBuilder: (context, index) {
  //             final category = _categories[index];
  //             return ListTile(
  //               leading: Image.network(
  //                 category.image,
  //                 width: 40,
  //                 height: 40,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return Icon(Icons.broken_image);
  //                 },
  //               ),
  //               title: Text(category.name),
  //               onTap: () {
  //                 Navigator.pushNamed(context, '/products',
  //                     arguments: category.id);
  //               },

  //               // subtitle: Text(category.image),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
