import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:currensee/models/articleModal.dart';
import 'package:currensee/models/slidermodal.dart';
import 'package:currensee/pages/news_detail.dart';
import 'package:currensee/services/news_api_service.dart';
import 'package:currensee/widgets/customText.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<SliderModal> topNewsData = [];
  List<ArticlesModal> articles = [];
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  Future<void> getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    setState(() {
      articles = newsClass.news;
      // Take the first four articles for the slider
      topNewsData = articles.take(4).map((article) {
        return SliderModal(
          title: article.title,
          author: article.publishedAt,
          urlToImage: article.urlToImage,
          url: article.url,
        );
      }).toList();
      // Take the rest of the articles for the latest news
      articles = articles.skip(4).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        title: MyText('News', Colors.white, 18),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText('WEDNESDAY, DECEMBER 20', Colors.grey, 14),
              const SizedBox(height: 10,),
              const Text(
                'Top News',
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(height: 20,),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.30,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
            ),
            items: topNewsData.map((data) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(blogUrl: data.url.toString()),));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(data.urlToImage!), // Use CachedNetworkImageProvider here
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data.author!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Lexend',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20,),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Latest',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(blogUrl: articles[index].url.toString()),));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white30,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: articles[index].urlToImage.toString(),
                              height: MediaQuery.of(context).size.height*0.20,
                              width: MediaQuery.of(context).size.width*0.40,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  articles[index].title.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Lexend',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  articles[index].description.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Lexend',
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(articles[index].publishedAt.toString(),style: const TextStyle(fontFamily: 'Lexend'),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
