import 'package:flutter/material.dart';

import '../view_models/logout_view_model.dart';
import '../view_models/video_view_model.dart';
import 'video_play_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final videoViewModel = VideoViewModel();
  final logoutViewModel = LogoutViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホームページ'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutViewModel.logout(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.video_library),
            onPressed: () {
              // ビデオを取得する処理を記述
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: videoViewModel.fetchVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('データがありません'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final videoData = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    // ここに動画再生ページに遷移する処理を記述
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayPage(videoId: videoData['video_id']),
                      ),
                    );
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Image.network(
                          videoData['thumbnail_image_url'], // サムネイルURLを反映
                          width: 100, // 画像の幅を指定
                          height: 56, // 画像の高さを指定
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              videoData['title'], // タイトルを反映
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              '再生回数 1 回', // 再生回数を反映
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
