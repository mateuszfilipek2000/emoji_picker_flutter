import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

void main() {
  final assetGitEmojiSet = <AssetEmoji>[];

  final gifAssets = [
    'aparat.gif',
    'beksa.gif',
    'hura.gif',
  ];

  for (final gif in gifAssets) {
    final name = gif.split('.').first;
    final backingValue = '<$name>';
    final gifPath = 'assets/gif/$gif';

    assetGitEmojiSet.add(
      AssetEmoji(name: name, value: backingValue, assetPath: gifPath),
    );
  }

  runApp(MyApp(
    assetGifEmojiSet: assetGitEmojiSet,
  ));
}

/// Example for EmojiPicker
class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.assetGifEmojiSet});

  final List<AssetEmoji> assetGifEmojiSet;

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _emojiShowing = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Emoji Picker Example App'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, text, child) {
                      return Text(
                        _controller.text,
                      );
                    },
                  ),
                ),
              ),
              Container(
                  height: 66.0,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _emojiShowing = !_emojiShowing;
                            });
                          },
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                              controller: _controller,
                              scrollController: _scrollController,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                  left: 16.0,
                                  bottom: 8.0,
                                  top: 8.0,
                                  right: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              )),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                            onPressed: () {
                              // send message
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      )
                    ],
                  )),
              Offstage(
                offstage: !_emojiShowing,
                child: EmojiPicker(
                  textEditingController: _controller,
                  scrollController: _scrollController,
                  config: Config(
                    emojiSet: [
                      ...defaultUnicodeEmojiSet,
                      CategoryEmoji(Category.CUSTOM, widget.assetGifEmojiSet),
                    ],
                    height: 256,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      emojiSizeMax: 28 *
                          (foundation.defaultTargetPlatform ==
                                  TargetPlatform.iOS
                              ? 1.2
                              : 1.0),
                    ),
                    swapCategoryAndBottomBar: false,
                    skinToneConfig: const SkinToneConfig(),
                    categoryViewConfig: const CategoryViewConfig(),
                    bottomActionBarConfig: const BottomActionBarConfig(),
                    searchViewConfig: const SearchViewConfig(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
