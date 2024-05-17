import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../presentations/resources/resources.dart';

class ImageService {
  ImageService({required this.serverUrl});
  final String serverUrl;

  String imagePath({required String tagId, required String id}) {
    return '$serverUrl/Items/$id/Images/Primary?fillHeight=420&fillWidth=420&quality=96&tag=$tagId';
  }

  ImageProvider albumIP({required String? tagId, required String id}) {
    if (tagId == null) return const AssetImage(Images.album);

    return CachedNetworkImageProvider('$serverUrl/Items/$id/Images/Primary?fillHeight=420&fillWidth=420&quality=96&tag=$tagId');
  }

  ImageProvider backdropIp({required String? tagId, required String id}) {
    if (tagId == null) return const AssetImage(Images.album);

    return CachedNetworkImageProvider('$serverUrl/Items/$id/Images/Backdrop?fillHeight=420&fillWidth=420&quality=96&tag=$tagId');
  }

  String _backdropPath({required String tagId, required String id}) {
    return '$serverUrl/Items/$id/Images/Backdrop?fillHeight=420&fillWidth=420&quality=96&tag=$tagId';
  }
}
