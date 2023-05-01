import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/read.dart';

import '../providers/api_service_providers.dart';
import '../widgets/image_container.dart';

class Pagination extends ConsumerWidget {
  Pagination({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {

      }
    });
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.menu,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          controller: scrollController,
          restorationId: "Items List",
          slivers: [
            Consumer(
              builder: (context, ref, child) {
                final data = ref.watch(beritaDataProvider);
                return data.when(
                  data: (items) {
                    return items.isEmpty
                        ? const SliverToBoxAdapter()
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ReadScreen(
                                        e: items[index],
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      ImageContainer(
                                        width: 80,
                                        height: 80,
                                        margin: const EdgeInsets.fromLTRB(
                                            5.0, 10.0, 5.0, 10.0),
                                        borderRadius: 5,
                                        imageUrl:
                                            "http://sungaipenuhkota.go.id/storage/${items[index].gambar}",
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              items[index].judul,
                                              maxLines: 3,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.schedule,
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${DateTime.now().difference(DateTime.parse(items[index].createdAt)).inHours} Jam yang lalu',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  items[index].nama,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: items.length,
                            ),
                          );
                  },
                  error: (err, s) => Text("error: $err"),
                  loading: () => const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
