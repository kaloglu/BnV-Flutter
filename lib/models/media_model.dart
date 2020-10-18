import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/base/base_model.dart';

@immutable
class Media extends BaseModel {
  final String path;
  final String type;

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

  factory Media.fromMap(Map<String, dynamic> data, [String documentId]) => Media(
        path: data['path'] ?? '',
        type: data['type'] ?? MediaType.IMAGE,
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
