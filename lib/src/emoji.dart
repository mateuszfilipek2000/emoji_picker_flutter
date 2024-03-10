// import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs

sealed class Emoji {
  const Emoji({
    required this.name,
    required this.value,
  });

  String get kind;

  final String name;

  /// value that will be sent to the input field
  /// after the emoji is selected
  final String value;

  static Emoji fromJson(Map<String, dynamic> json) {
    switch (json['kind'] as String) {
      case 'unicode':
        return UnicodeEmoji.fromJson(json);
      case 'asset':
        return AssetEmoji.fromJson(json);
      default:
        throw ArgumentError('Invalid kind: ${json['kind']}');
    }
  }

  Map<String, dynamic> toJson();
}

final class UnicodeEmoji extends Emoji {
  const UnicodeEmoji(
    /// unicode value of the emoji
    String value,

    /// name of the emoji
    String name, {
    this.hasSkinTone = false,
  }) : super(name: name, value: value);

  final bool hasSkinTone;

  @override
  String get kind => 'unicode';

  static UnicodeEmoji fromJson(Map<String, dynamic> json) {
    return UnicodeEmoji(
      json['name'] as String,
      json['value'] as String,
      hasSkinTone: json['hasSkinTone'] as bool,
    );
  }

  UnicodeEmoji copyWith({
    String? name,
    String? value,
    bool? hasSkinTone,
  }) {
    return UnicodeEmoji(
      name ?? this.name,
      value ?? this.value,
      hasSkinTone: hasSkinTone ?? this.hasSkinTone,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'hasSkinTone': hasSkinTone,
      'kind': kind,
    };
  }
}

final class AssetEmoji extends Emoji {
  const AssetEmoji({
    required String name,
    required String value,
    required this.assetPath,
  }) : super(name: name, value: value);

  final String assetPath;

  @override
  String get kind => 'asset';

  static AssetEmoji fromJson(Map<String, dynamic> json) {
    return AssetEmoji(
      name: json['name'] as String,
      value: json['value'] as String,
      assetPath: json['assetPath'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'assetPath': assetPath,
      'kind': kind,
    };
  }

  AssetEmoji copyWith({
    String? name,
    String? value,
    String? assetPath,
  }) {
    return AssetEmoji(
      name: name ?? this.name,
      value: value ?? this.value,
      assetPath: assetPath ?? this.assetPath,
    );
  }
}
