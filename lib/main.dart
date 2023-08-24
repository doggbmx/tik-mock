import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_post_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';

import 'presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostDataSource = LocalVideoDataSourceImplementation();
    final videoPostRepository = VideoPostRepositoryImplementation(
        videoPostDataSource: videoPostDataSource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DiscoverProvider>(
          // FORCE LOAD
          lazy: false,
          create: (_) => DiscoverProvider(
            videosRepository: videoPostRepository,
          )..loadNextPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        title: 'TikMock',
        home: const DiscoverScreen(),
      ),
    );
  }
}
