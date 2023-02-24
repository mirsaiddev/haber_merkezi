import 'package:flutter/material.dart';
import 'package:news_app_v1/models/new_model.dart';
import 'package:news_app_v1/providers/data_provider.dart';
import 'package:news_app_v1/screens/CategoryDetail/category_detail.dart';
import 'package:news_app_v1/theme/colors.dart';
import 'package:news_app_v1/utils/navigator_state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    DataProvider categoriesProvider = Provider.of<DataProvider>(context, listen: false);
    categoriesProvider.categories;
    List<Map> initialNews = categoriesProvider.initialNews.where((element) => element['category_id'] != 5).toList();
    List<NewModel> trendNews =
        categoriesProvider.initialNews.isNotEmpty ? categoriesProvider.initialNews.where((element) => element['category_id'] == 5).first['news'] : [];

    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset('lib/assets/icons/logo.png'),
                                ),
                                radius: 20,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Haberin Merkezi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                    Text('Güncel Haberler', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Kategoriler',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.4)),
                      ),
                      SizedBox(height: 10),
                      for (Map category in categoriesProvider.categories)
                        GestureDetector(
                          onTap: () {
                            print(category);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetail(
                                  categoryId: int.parse(category['id']),
                                  categoryName: category['Baslik'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.symmetric(vertical: 11),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(Icons.open_in_new, size: 12),
                                SizedBox(width: 10),
                                Text(
                                  '${category['Baslik']}',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.65)),
                                ),
                                // Spacer(),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: MyColors.greenLight,
                                //     borderRadius: BorderRadius.circular(4),
                                //   ),
                                //   height: 24,
                                //   width: 24,
                                //   child: Center(
                                //     child: Text(
                                //       '10',
                                //       style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     launchUrlString('https://instagram.com/morgenmarktde');
                          //   },
                          //   child: Image.asset('lib/assets/icons/Facebook.png', height: 30),
                          // ),
                          // SizedBox(width: 10),
                          // GestureDetector(
                          //     onTap: () {
                          //       launchUrlString('https://instagram.com/morgenmarktde');
                          //     },
                          //     child: Image.asset('lib/assets/icons/Instagram.png', height: 30)),
                          // SizedBox(width: 10),
                          // Image.asset('lib/assets/icons/Twitter.png', height: 30),
                          // SizedBox(width: 10),
                          // Image.asset('lib/assets/icons/Youtube.png', height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        bool canLaunch = await canLaunchUrlString('https://www.instagram.com/habermerkezionline/');
                        if (canLaunch) {
                          launchUrlString('https://www.instagram.com/habermerkezionline/');
                        }
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/instagram.png',
                            height: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text('habermerkezionline'),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        bool canLaunch = await canLaunchUrlString('https://twitter.com/HaberMerkeziOn');
                        if (canLaunch) {
                          launchUrlString('https://twitter.com/HaberMerkeziOn');
                        }
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/twitter.png',
                            height: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text('HaberMerkeziOn'),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        bool canLaunch = await canLaunchUrlString('https://www.facebook.com/people/Son-Dakika-Haber/100089363987054/');
                        if (canLaunch) {
                          launchUrlString('https://www.facebook.com/people/Son-Dakika-Haber/100089363987054/');
                        }
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/facebook.png',
                            height: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text('Son Dakika Haber'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(endIndent: 24, indent: 24, thickness: 2),
              SizedBox(height: 8),
              Text(
                'kundenservice@morgenmarkt.de',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.65)),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _key.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.menu),
                    ),
                    Text(
                      'Son Dakika Haberleri',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.greyDark),
                    ),
                    Spacer(),
                    // CircleAvatar(
                    //   backgroundColor: Colors.grey,
                    //   radius: 20,
                    // ),
                    // SizedBox(width: 16),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Builder(builder: (context) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 24),
                      for (NewModel newModel in trendNews) NewCard(newModel: newModel),
                    ],
                  ),
                );
              }),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: initialNews.length,
                  itemBuilder: (context, index) {
                    Map newMap = initialNews[index];
                    String category = newMap['category_name'];
                    List<NewModel> news = newMap['news'];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.greyDark),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              color: MyColors.greyDark,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetail(
                                      categoryId: newMap['category_id'],
                                      categoryName: newMap['category_name'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Divider(thickness: 1),
                        SizedBox(height: 4),
                        for (NewModel newModel in news) NewTile(newModel: newModel),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewTile extends StatelessWidget {
  const NewTile({
    Key? key,
    required this.newModel,
  }) : super(key: key);

  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(newModel.url);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 90,
                width: 90,
                child: Image.network(newModel.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newModel.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColors.greyDark),
                  ),
                  SizedBox(height: 8),
                  Text(newModel.site, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: MyColors.grey1)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      // Image.asset('lib/assets/icons/Heart.png', height: 16, width: 16),
                      // SizedBox(width: 4),
                      // Text('6', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: MyColors.grey1)),
                      // SizedBox(width: 16),
                      // Image.asset('lib/assets/icons/Chat.png', height: 16, width: 16),
                      // SizedBox(width: 4),
                      // Text('2', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: MyColors.grey1)),
                      // SizedBox(width: 16),
                      Text(newModel.date, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: MyColors.grey1)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard({
    Key? key,
    required this.newModel,
  }) : super(key: key);

  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(newModel.url);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => NewDetailScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 270,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 170,
                    width: 270,
                    child: Image.network(
                      newModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  newModel.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: MyColors.greyDark,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: 24,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: MyColors.greyLight,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    newModel.category,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.indigo),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  newModel.date,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.grey1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
