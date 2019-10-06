import 'package:bnv/enums.dart';
import 'package:bnv/model/base/base_model.dart';
import 'package:flutter/material.dart';

@immutable
class Media extends BaseModel {
  final String path;
  final ProductType type;

  const Media({
    Key key,
    this.path,
    this.type,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'path': path,
        'type': type,
      };

  static Media fromMap(Map data, [String documentId]) => Media(
        path: data['path'] ?? '',
        type: data['type'] ?? ProductType.IMAGE,
      );

  static List<Media> listFromMap(
    List listMap,
  ) {
    List<Media> med = [];
    listMap.map((m) {
      med.add(Media.fromMap(m));
    });
    return [];
  }
}
