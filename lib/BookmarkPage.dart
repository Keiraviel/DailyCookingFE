import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'HowToMakePage.dart';

class BookmarkPage extends StatefulWidget {
  final Set<int> bookmarkedRecipes;
  final List<Map<String, String>> recipes;
  final Function(Set<int>) onBookmarkChanged;

  const BookmarkPage({
    required this.bookmarkedRecipes,
    required this.recipes,
    required this.onBookmarkChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHowToMake(BuildContext context, Map<String, String> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => HowToMakePage(
              recipeTitle: recipe['title']!,
              recipeImage: recipe['image']!,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final bookmarkedList =
        widget.recipes
            .asMap()
            .entries
            .where((entry) => widget.bookmarkedRecipes.contains(entry.key))
            .map((entry) => entry.value)
            .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Bookmark',
          style: TextStyle(
            color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.05,
          ),
        ),
        actions: [
          Row(
            children: const [
              Tooltip(
                message: 'Notifikasi',
                child: Icon(Icons.notifications_none, color: Colors.white),
              ),
              SizedBox(width: 12),
              Tooltip(
                message: 'Cari resep',
                child: Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          
        ],
      ),
      body:
          bookmarkedList.isEmpty
              ? Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                math.sin(_controller.value * 2 * math.pi) * 10,
                              ),
                              child: child,
                            );
                          },
                          child: Image.asset(
                            'assets/onboard/empty.png',
                            width: width * 0.5,
                            height: height * 0.3,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Text(
                          "Oops! Belum ada resep favoritmu di sini.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        Text(
                          "Yuk, mulai bookmark resep yang kamu suka dengan menekan ikon bookmark!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: GridView.builder(
                    itemCount: bookmarkedList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width > 800 ? 3 : 2,
                      crossAxisSpacing: width * 0.02,
                      mainAxisSpacing: width * 0.02,
                      childAspectRatio: width > 800 ? 0.8 : 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final recipe = bookmarkedList[index];
                      final originalIndex = widget.recipes.indexOf(
                        bookmarkedList[index],
                      );

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(width * 0.04),
                              ),
                              child: Image.asset(
                                recipe['image']!,
                                height: height * 0.18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03,
                                vertical: height * 0.01,
                              ),
                              child: Text(
                                recipe['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03,
                                vertical: height * 0.005,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed:
                                          () => _navigateToHowToMake(
                                            context,
                                            recipe,
                                          ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            width * 0.02,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: height * 0.012,
                                        ),
                                      ),
                                      child: Text(
                                        'How To Make',
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.015),
                                  IconButton(
                                    icon: Icon(
                                      widget.bookmarkedRecipes.contains(
                                            originalIndex,
                                          )
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: Colors.deepOrange,
                                      size: width * 0.065,
                                    ),
                                    onPressed: () {
                                      widget.onBookmarkChanged(
                                        Set.from(widget.bookmarkedRecipes)
                                          ..remove(originalIndex),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
    );
  }
}
