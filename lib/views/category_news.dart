import 'package:flutter/material.dart';
import 'package:flutter_app/helper/news.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews(this.category);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var articles;
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true
      ),
        body: _loading
            ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        )
            : SingleChildScrollView(
              child: Container(
          child: Column(
              children: <Widget>[
                /// BLogs
                Container(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 16),
                      shrinkWrap: true,
                      itemCount: articles.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageurl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                        );
                      }),
                ),

                ///Blogs
              ],
          ),
        ),
            )
    );
  }
}


class BlogTile extends StatelessWidget {
  final String imageurl, title, desc,url;

  BlogTile({this.imageurl, this.title, this.desc,this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return ArticleView(
            blogurl: url,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(imageurl)),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

