import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:emoji_picker_flutter/src/emoji_picker_internal_utils.dart';
import 'package:test/test.dart';

void main() {
  skinToneTests();
  emojiModelTests();
}

void skinToneTests() {
  final internalUtils = EmojiPickerInternalUtils();
  final utils = EmojiPickerUtils();

  test('applySkinTone()', () {
    expect(
      utils.applySkinTone(const UnicodeEmoji('👍', ''), SkinTone.light).value,
      '👍🏻',
    );
    expect(
      utils
          .applySkinTone(const UnicodeEmoji('🏊‍♂️', ''), SkinTone.mediumDark)
          .value,
      '🏊🏾‍♂️',
    );
    expect(
      utils.applySkinTone(const UnicodeEmoji('👱‍♀️', ''), SkinTone.dark).value,
      '👱🏿‍♀️',
    );
  });

  test('removeSkinTone()', () {
    expect(internalUtils.removeSkinTone(const UnicodeEmoji('👍🏻', '')).value,
        '👍');
    expect(
        internalUtils.removeSkinTone(const UnicodeEmoji('🏊🏾‍♂️', '')).value,
        '🏊‍♂️');
    expect(
        internalUtils.removeSkinTone(const UnicodeEmoji('👱🏿‍♀️', '')).value,
        '👱‍♀️');
  });
}

void emojiModelTests() {
  test('encode Emoji', () {
    final encode = const UnicodeEmoji('🤣', 'name');
    expect(encode.toJson(),
        <String, dynamic>{'emoji': '🤣', 'name': 'name', 'hasSkinTone': false});
  });

  test('decode Emoji without hasSkinTone property', () {
    final decode = <String, dynamic>{'name': 'name', 'emoji': '🤣'};
    final result = Emoji.fromJson(decode);
    expect(result.name, 'name');
    expect(result.value, '🤣');

    final hasSkintone = result as UnicodeEmoji;
    expect(hasSkintone, false);
  });

  test('decode Emoji with hasSkinTone property', () {
    final decode = <String, dynamic>{
      'name': 'name',
      'emoji': '🤣',
      'hasSkinTone': true
    };
    final result = Emoji.fromJson(decode);
    expect(result.name, 'name');
    expect(result.value, '🤣');
    final hasSkinTone = result as UnicodeEmoji;

    expect(hasSkinTone, true);
  });
}
