import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'utils.dart';
import 'widgets.dart';

import 'new_project.dart';

class HomeTab extends StatefulWidget {
  static const title = 'Home';
  static const androidIcon = Icon(Icons.home);
  static const iosIcon = Icon(CupertinoIcons.home);

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Widget _tabBar(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: const SafeArea(
          child: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Projects',
              ),
              Tab(
                text: 'People',
              )
            ],
          ),
        )),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ProjectsPage(),
            ),
            Center(child: PeoplePage())
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(HomeTab.title),
        ),
        body: _tabBar(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Feed'),
        ),
        child: _tabBar(context));
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

// Projects Page
class ProjectsPage extends StatelessWidget {
  Widget _listBuilder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/skateboard.jpg', // Replace with your asset image path
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Header',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Description blah blah blah'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: PeoplePage._itemsLength,
          itemBuilder: _listBuilder,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProject()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// People Page
class PeoplePage extends StatefulWidget {
  static const _itemsLength = 20;

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage>
    with AutomaticKeepAliveClientMixin {
  late final List<Color> colors;
  late final List<String> titles;
  late final List<String> contents;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    colors = getRandomColors(PeoplePage._itemsLength);
    titles = List.generate(
        PeoplePage._itemsLength, (index) => generateRandomHeadline());
    contents = List.generate(
        PeoplePage._itemsLength, (index) => lorem(paragraphs: 1, words: 24));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: PeoplePage._itemsLength,
      itemBuilder: (BuildContext context, int index) {
        return listBuilderPeople(
            context, index, titles, colors); // Using the listBuilder function
      },
    );
  }
}
