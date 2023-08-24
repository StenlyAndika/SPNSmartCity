import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';

import 'webkota/models/service/model_service.dart';
import 'webkota/providers/service/service.dart';
import '../../../widgets/header.dart';
import '../../../widgets/reusable_widgets.dart';
import '../../../widgets/skeleton.dart';

class Service extends ConsumerStatefulWidget {
  const Service({Key? key}) : super(key: key);

  static const nameRoute = '/pesan';

  @override
  ConsumerState createState() => _ServiceState();
}

class _ServiceState extends ConsumerState<Service> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        final state = ref.watch(serviceProvider);
        if (!state.isLoading) {
          ref.read(serviceProvider.notifier).loadMoreService();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ServiceModel pesan = ref.watch(serviceProvider).modelService;
    final state = ref.watch(serviceProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 65, 180),
      body: ListView(
        children: [
          const Header(
              title: 'Pesan',
              subtitle: "Keluh Kesah Masyarakat Negara Berkembang"),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 110),
              child: Column(
                children: [
                  state.isLoading
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return const CardServiceSkeleton();
                            },
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: pesan.payload!.data!.length + 1,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == pesan.payload!.data!.length) {
                                if (state.hasMoreData!) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CardPesan(
                                    pesan: pesan.payload!.data![index]),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardServiceSkeleton extends StatelessWidget {
  const CardServiceSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 0.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const Row(
          children: [
            Skeleton(
              width: 130,
              height: 130,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      width: 80,
                      height: 20,
                    ),
                    SizedBox(height: 5),
                    Skeleton(
                      width: double.infinity,
                      height: 20,
                    ),
                    SizedBox(height: 5),
                    Skeleton(
                      width: double.infinity,
                      height: 20,
                    ),
                    SizedBox(height: 5),
                    Skeleton(
                      width: double.infinity,
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardPesan extends ConsumerWidget {
  final Data pesan;
  const CardPesan({Key? key, required this.pesan}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (e) {
              
            },
            backgroundColor: const Color(0xFFFE4A49),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            icon: Icons.delete,
            label: 'Hapus',
            padding: const EdgeInsets.all(10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff1D1617).withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 0.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ReusableWidgets.time_passed(
                          DateTime.parse(pesan.createdAt.toString()),
                          full: false),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      height: 5,
                      thickness: 2,
                      // endIndent: 250,
                      color: Colors.black26,
                    ),
                    Text(
                      pesan.nama.toString(),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
