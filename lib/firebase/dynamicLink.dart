import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/productDetail.dart';

Future<String> createLink(String productId)async{
  print(productId);
  String url="https://amk4soft.page.link";
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("$url/$productId"),
    uriPrefix: url,
    androidParameters: const AndroidParameters(
      packageName: "com.amk4soft.my_chat",
      minimumVersion: 0,
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.amk4soft.myChat",
      appStoreId: "123456789",
      minimumVersion: "1.0.1",
    ),

    socialMetaTagParameters: SocialMetaTagParameters(
      title: "Example of a Dynamic Link",
    ),
  );
  final dynamicLink =
  await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  return dynamicLink.shortUrl.toString();
}
initDynamicLink(BuildContext context)async{
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    List<String> s=dynamicLinkData.link.toString().split('/');
    Navigator.push(context, MaterialPageRoute(builder: (context){return ProductDetail(s[s.length-1]);}));
    print(dynamicLinkData.link);
  }).onError((error) {
    print(error.toString());
  });
}