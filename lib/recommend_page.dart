import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, int> _cart = {};

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 1, vsync: this); // TabController length를 1로 변경
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
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              _showCart();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '추천창'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecommendTab(),
        ],
      ),
    );
  }

  Widget _buildRecommendTab() {
    return ListView(
      children: List.generate(
          50,
          (index) => Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('추천 약 ${index + 1}'),
                  onTap: () => _showAddToCartDialog('추천 약 ${index + 1}'),
                ),
              )),
    );
  }

  void _showAddToCartDialog(String item) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('$item 장바구니에 담겠습니까?'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (_cart.containsKey(item)) {
                        _cart[item] = _cart[item]! + quantity;
                      } else {
                        _cart[item] = quantity;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _cart.entries.map((entry) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('${entry.key} x${entry.value}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (entry.value > 1) {
                                      _cart[entry.key] = entry.value - 1;
                                    } else {
                                      _cart.remove(entry.key);
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _cart[entry.key] = entry.value + 1;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _cart.remove(entry.key);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
