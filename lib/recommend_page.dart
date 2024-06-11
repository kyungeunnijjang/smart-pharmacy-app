import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 약 구매'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '추천창'),
            Tab(text: '즐겨찾기'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecommendTab(),
          _buildFavoritesTab(),
        ],
      ),
    );
  }

  Widget _buildRecommendTab() {
    return ListView(
      children: List.generate(
          50, (index) => ListTile(title: Text('추천 약 ${index + 1}'))),
    );
  }

  Widget _buildFavoritesTab() {
    return ListView(
      children: List.generate(
          50, (index) => ListTile(title: Text('즐겨찾기 약 ${index + 1}'))),
    );
  }
}
