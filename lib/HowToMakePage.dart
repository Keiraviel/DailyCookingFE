import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';

class HowToMakePage extends StatefulWidget {
  final String recipeTitle;
  final String recipeImage;

  const HowToMakePage({
    required this.recipeTitle,
    required this.recipeImage,
    Key? key,
  }) : super(key: key);

  @override
  State<HowToMakePage> createState() => _HowToMakePageState();
}

class _HowToMakePageState extends State<HowToMakePage> with TickerProviderStateMixin {
  final Map<String, List<Map<String, dynamic>>> dummyIngredients = {
    'Nasi Goreng': [
      {'name': 'Rice', 'quantity': '1 plate', 'icon': Icons.rice_bowl},
      {'name': 'Onion', 'quantity': '2 pieces', 'icon': Icons.food_bank},
      {'name': 'Soy sauce', 'quantity': '1 tbsp', 'icon': Icons.soup_kitchen},
      {'name': 'Egg', 'quantity': '1', 'icon': Icons.egg},
    ],
    'Ifu Mie': [
      {'name': 'Mie Kering', 'quantity': '1 pack', 'icon': Icons.ramen_dining},
      {'name': 'Vegetables', 'quantity': 'as needed', 'icon': Icons.eco},
    ],
  };

  final Map<String, List<String>> dummySteps = {
    'Nasi Goreng': [
      'Panaskan minyak dan tumis bawang hingga harum.',
      'Masukkan nasi dan aduk rata.',
      'Tambahkan kecap dan telur, masak hingga matang.',
      'Sajikan hangat.',
    ],
    'Ifu Mie': [
      'Rebus mie kering hingga setengah matang.',
      'Tumis sayuran dan tambahkan bumbu.',
      'Campurkan mie dan sayuran, aduk rata.',
      'Masak hingga matang dan sajikan.',
    ],
  };

  late TabController _tabController;
  double _rating = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {}); // Trigger rebuild when tab changes
  }

  String _emojiForRating(double value) {
    if (value <= 1.5) return '😢';
    if (value <= 2.5) return '😐';
    if (value <= 3.5) return '🙂';
    if (value <= 4.5) return '😊';
    return '😄';
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Get Link'),
            onTap: () {
              FlutterClipboard.copy(
                'https://resepmu.com/${widget.recipeTitle.replaceAll(' ', '_').toLowerCase()}',
              ).then((_) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link berhasil disalin!')),
                );
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              final shareText =
                  'Lihat resep ${widget.recipeTitle} di aplikasi kami: https://resepmu.com/${widget.recipeTitle.replaceAll(' ', '_').toLowerCase()}';
              Share.share(shareText);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Laporkan'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dilaporkan ke admin.')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = dummyIngredients[widget.recipeTitle] ?? [];
    final steps = dummySteps[widget.recipeTitle] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5D7A1),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          widget.recipeTitle,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Ingredients'),
            Tab(text: 'Cara Membuat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ingredients Tab
          _buildIngredientsTab(ingredients),
          // Steps Tab
          _buildStepsTab(steps),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton.extended(
              onPressed: _showBottomSheet,
              backgroundColor: Colors.deepPurple,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text('', style: TextStyle(color: Colors.white)),
            )
          : null,
    );
  }

  Widget _buildIngredientsTab(List<Map<String, dynamic>> ingredients) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ingredients.isEmpty
          ? Center(child: Text('Bahan belum tersedia untuk ${widget.recipeTitle}'))
          : Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.recipeImage, height: 150),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: ingredients.map((item) {
                      return ListTile(
                        leading: Icon(item['icon'], color: Colors.brown),
                        title: Text(item['name']),
                        trailing: Text(item['quantity']),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStepsTab(List<String> steps) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: steps.isEmpty
          ? Center(child: Text('Langkah belum tersedia untuk ${widget.recipeTitle}'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(steps[index]),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _showRatingDialog,
                  icon: const Icon(Icons.star),
                  label: const Text('Rating Resep'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _showRatingDialog() async {
    final rating = await showDialog<double>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Beri Rating Resep Ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setStateDialog) {
                return Column(
                  children: [
                    Text(
                      _emojiForRating(_rating),
                      style: const TextStyle(fontSize: 48),
                    ),
                    Slider(
                      value: _rating,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _emojiForRating(_rating),
                      activeColor: Colors.amber,
                      onChanged: (value) {
                        setStateDialog(() {
                          _rating = value;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context, _rating),
                child: const Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );

    if (rating != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terima kasih! Rating: ${_emojiForRating(rating)}'),
        ),
      );
    }
  }
}