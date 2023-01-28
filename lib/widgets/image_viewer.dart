import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

// class ImageviewerPage extends StatefulWidget {
//   final int initialIndex;
//   final List<String> imageUrls;
//   const ImageviewerPage({
//     Key? key,
//     required this.initialIndex,
//     required this.imageUrls,
//   }) : super(key: key);

//   @override
//   _ImageviewerPageState createState() => _ImageviewerPageState();
// }

// class _ImageviewerPageState extends State<ImageviewerPage> {
//   final _pageController = PageController();
//   static const _kDuration = Duration(milliseconds: 300);
//   static const _kCurve = Curves.ease;

//   final List<ImageProvider> _imageProviders = [
//     Image.network("https://picsum.photos/id/1001/4912/3264").image,
//     Image.network("https://picsum.photos/id/1003/1181/1772").image,
//     Image.network("https://picsum.photos/id/1004/4912/3264").image,
//     Image.network("https://picsum.photos/id/1005/4912/3264").image
//   ];

//   late final _easyEmbeddedImageProvider = MultiImageProvider(_imageProviders);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//               child: const Text("Show Single Image"),
//               onPressed: () {
//                 showImageViewer(
//                     context,
//                     Image.network("https://picsum.photos/id/1001/4912/3264")
//                         .image,
//                     swipeDismissible: true,
//                     doubleTapZoomable: true);
//               }),
//           ElevatedButton(
//               child: const Text("Show Multiple Images (Simple)"),
//               onPressed: () {
//                 MultiImageProvider multiImageProvider =
//                     MultiImageProvider(_imageProviders);
//                 showImageViewerPager(context, multiImageProvider,
//                     swipeDismissible: true, doubleTapZoomable: true);
//               }),
//           ElevatedButton(
//               child: const Text("Show Multiple Images (Custom)"),
//               onPressed: () {
//                 CustomImageProvider customImageProvider = CustomImageProvider(
//                     imageUrls: [
//                       "https://picsum.photos/id/1001/4912/3264",
//                       "https://picsum.photos/id/1003/1181/1772",
//                       "https://picsum.photos/id/1004/4912/3264",
//                       "https://picsum.photos/id/1005/4912/3264"
//                     ].toList(),
//                     initialIndex: 2);
//                 showImageViewerPager(context, customImageProvider,
//                     onPageChanged: (page) {
//                   // print("Page changed to $page");
//                 }, onViewerDismissed: (page) {
//                   // print("Dismissed while on page $page");
//                 });
//               }),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 2.0,
//             child: EasyImageViewPager(
//                 easyImageProvider: _easyEmbeddedImageProvider,
//                 pageController: _pageController),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   child: const Text("<< Prev"),
//                   onPressed: () {
//                     final currentPage = _pageController.page?.toInt() ?? 0;
//                     _pageController.animateToPage(
//                         currentPage > 0 ? currentPage - 1 : 0,
//                         duration: _kDuration,
//                         curve: _kCurve);
//                   }),
//               ElevatedButton(
//                   child: const Text("Next >>"),
//                   onPressed: () {
//                     final currentPage = _pageController.page?.toInt() ?? 0;
//                     final lastPage = _easyEmbeddedImageProvider.imageCount - 1;
//                     _pageController.animateToPage(
//                         currentPage < lastPage ? currentPage + 1 : lastPage,
//                         duration: _kDuration,
//                         curve: _kCurve);
//                   }),
//             ],
//           )
//         ],
//       )),
//     );
//   }
// }

class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageProvider({required this.imageUrls, required this.initialIndex})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    // return CachedNetworkImage(
    //   imageUrl: imageUrls[index],
    //   imageBuilder: (context, imageProvider) => Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: imageProvider,
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //   ),
    //   // placeholder: (context, url) => const CircularProgressIndicator(),
    //   // errorWidget: (context, url, error) => const Icon(Icons.error),
    // );

    return NetworkImage(imageUrls[index]);
  }

  @override
  int get imageCount => imageUrls.length;
}
