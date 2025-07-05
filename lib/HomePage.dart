import 'package:flutter/material.dart';
import 'package:tugasaplikasi/BookmarkPage.dart';
import 'package:tugasaplikasi/ChatPage.dart';
import 'package:tugasaplikasi/HowToMakePage.dart';
import 'package:tugasaplikasi/AccountPage.dart';

class HomePage extends StatefulWidget {
  final Set<int> bookmarked;
  final Function(Set<int>) onBookmarkChanged;

  const HomePage({
    required this.bookmarked,
    required this.onBookmarkChanged,
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoading = true;
  int _selectedTabIndex = 0;

  final List<String> tabTitles = ['Rekomendasi', 'Cepat', 'Populer'];

  final Map<String, List<Map<String, String>>> categorizedRecipes = {
    'Rekomendasi': [
      {'title': 'Nasi Goreng', 'image': 'assets/menu/nasi_goreng.jpg'},
      {'title': 'Ifu Mie', 'image': 'assets/menu/ifumie.png.jpg'},
      {'title': 'Roti Bakar', 'image': 'assets/menu/rotibakar.png.jpg'},
    ],
    'Cepat': [
      {'title': 'Roti Bakar', 'image': 'assets/menu/rotibakar.png.jpg'},
      {'title': 'Borgar', 'image': 'assets/menu/burger.png.jpg'},
    ],
    'Populer': [
      {'title': 'Rendang', 'image': 'assets/menu/rendang.jpg'},
      {'title': 'Cotto Makasar', 'image': 'assets/menu/soto.jpg'},
    ],
  };

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _pages = [
      _buildHomePage(screenWidth, screenHeight),
      BookmarkPage(
        bookmarkedRecipes: widget.bookmarked,
        recipes: categorizedRecipes[tabTitles[_selectedTabIndex]]!,
        onBookmarkChanged: (updatedBookmarks) {
          setState(() {
            widget.bookmarked.clear();
            widget.bookmarked.addAll(updatedBookmarks);
          });
        },
      ),
      const ChatPage(),
      const AccountPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {},
              child: const Icon(Icons.restaurant_menu, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildHomePage(double screenWidth, double screenHeight) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(),
              SizedBox(height: screenHeight * 0.02),
              _buildAdsSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildTitleSection("Menu"),
              _buildTabBar(),
              const SizedBox(height: 8),
              _buildTitleSection(tabTitles[_selectedTabIndex]),
              _buildRecipeGrid(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Good Morning 👋",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
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
    );
  }

  Widget _buildAdsSection(double screenWidth, double screenHeight) {
    double adHeight = screenHeight * 0.25;
    return SizedBox(
      height: adHeight,
      child: PageView(
        controller: _pageController,
        children: [
          _adCard('assets/ads/ads1.png'),
          _adCard('assets/ads/ads2.png'),
          _adCard('assets/ads/ads3.jpg'),
        ],
      ),
    );
  }

  Widget _adCard(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTitleSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabTitles.length, (index) {
              final isSelected = _selectedTabIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.orange : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Text(
                    tabTitles[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRecipeGrid(double screenWidth) {
    final selectedCategory = tabTitles[_selectedTabIndex];
    final selectedRecipes = categorizedRecipes[selectedCategory]!;
    int crossAxisCount = screenWidth > 800 ? 3 : 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: selectedRecipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final recipe = selectedRecipes[index];
          return _buildRecipeCard(recipe, index, screenWidth);
        },
      ),
    );
  }

  Widget _buildRecipeCard(
      Map<String, String> recipe, int index, double screenWidth) {
    double imageHeight = screenWidth * 0.3;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              recipe['image']!,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              recipe['title']!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HowToMakePage(
                            recipeTitle: recipe['title']!,
                            recipeImage: recipe['image']!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: const Text(
                      'Masak?',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    widget.bookmarked.contains(index)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      if (widget.bookmarked.contains(index)) {
                        widget.bookmarked.remove(index);
                      } else {
                        widget.bookmarked.add(index);
                      }
                    });
                    widget.onBookmarkChanged(widget.bookmarked);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.orange,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}
