import 'package:flutter/material.dart';
import 'package:news_api_app/view/tabs/business_page.dart';
import 'package:news_api_app/view/tabs/health_page.dart';
import 'package:news_api_app/view/tabs/tech_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          title: const Text("News App", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Text('Business'),
                  ),
                  Tab(
                    child: Text('Technology'),
                  ),
                  Tab(
                    child: Text('Health'),
                  ),
                ],
              ),
            ),
          ),
          body:  TabBarView(
            controller: _tabController,
            children: const[
              BusinessPage(),
              TechPage(),
              HealthPage(),

            ],
          ),
        ),
      ),
    );
  }
}
