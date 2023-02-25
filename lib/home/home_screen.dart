import 'package:flutter/material.dart';


import '../api/api.dart';

import '../model/newsm_model/newsm_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<List<NewsmModel>>? futureNews;
  final _searchNewsController = TextEditingController();
  @override
  void initState() {
    futureNews = fetchNews(newsSearch: 'india');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffb51248),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _searchNewsController,
                decoration: InputDecoration(
                    hintText: 'Search news here',
                    suffixIcon: IconButton(
                        onPressed: () async {
                          setState(() {
                            futureNews = fetchNews(
                                newsSearch: _searchNewsController.text);
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ))),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<NewsmModel>>(
                future: futureNews,
                builder: (context, AsyncSnapshot<List<NewsmModel>> snapshot) {
                  if (snapshot.hasData) {
                    final news = snapshot.data!;
                    //for display data
                    return ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (BuildContext context, int index) {
                        final allNews = news[index];
                        return ListTile(
                          title: Text(
                            allNews.author ?? "erro getting title",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(allNews.title ?? ""),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(allNews.description ?? ""),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.network(allNews.urlToImage ?? ""),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(allNews.publishedAt ?? ""),
                              Text(allNews.content ?? "")
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final allNews = snapshot.data![index];
                        return ListTile(
                          title: Text(
                            allNews.author ?? "erro getting title",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(allNews.title ?? ""),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(allNews.description ?? ""),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.network(allNews.urlToImage ?? ""),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(allNews.publishedAt ?? ""),
                              Text(allNews.content ?? "")
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Somthing went wrong !!'),
                    );
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
