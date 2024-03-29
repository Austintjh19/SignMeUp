import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:myapplication/src/common_widgets/UnorderedListText.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/GeneralEventController.dart';
import 'package:myapplication/src/common_widgets/VerticalScrollEventsWidget.dart';

import '../../Dashboard.dart';
import '../../controllers/SearchEventController.dart';

class DashboardSearchScreen extends ConsumerStatefulWidget {
  const DashboardSearchScreen({super.key});

  @override
  ConsumerState<DashboardSearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<DashboardSearchScreen> {
  final generalEventController = Get.put(GeneralEventController());
  final searchEventController = Get.put(SearchEventController());

  Future<void> _refreshScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(Dashboard(initialPageIndex: 1));
    return Future.delayed(const Duration(seconds: 0));
  }

  void _searchQuery() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor100,
      body: LiquidPullToRefresh(
        onRefresh: _refreshScreen,
        color: primaryColor100,
        backgroundColor: primaryColor300,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        height: 200,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    // Events Search Bar =======================================
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: defaultBoxShadow,
                          color: primaryColor100),
                      child: TextFormField(
                        controller: searchEventController.stringQuery,
                        onChanged: (query) {
                          searchEventController.searchEventsFilteredBy(
                              ref.watch(searchFilterStateProvider).keys.first,
                              ref
                                  .watch(searchFilterStateProvider)
                                  .values
                                  .first);
                          _searchQuery();
                        },
                        maxLines: 1,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: textColor600),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            fillColor: primaryColor100,
                            filled: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(
                                Icons.search_outlined,
                                color: primaryColor600,
                                size: 20,
                              ),
                            ),
                            hintText: 'Search ... ',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu_outlined,
                                  color: primaryColor600,
                                  size: 20,
                                ),
                                onPressed: () {
                                  searchEventController
                                      .getSearchFilterPopUp(context);
                                },
                              ),
                            ),
                            focusColor: primaryColor600),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Event List ==============================================
                    FutureBuilder(
                        future: searchEventController.searchEventsFilteredBy(
                            ref.watch(searchFilterStateProvider).keys.first,
                            ref.watch(searchFilterStateProvider).values.first),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (c, index) {
                                    return VerticalScrollEventsWidget(
                                      event: snapshot.data![index],
                                    );
                                  });
                            }
                            // No Matching Events ------------------------------
                            return Container(
                              padding: const EdgeInsets.fromLTRB(5, 30, 10, 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your search - ${searchEventController.stringQuery.text} - did not match any documetns.',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text('Suggections:'),
                                  const SizedBox(height: 15),
                                  const UnorderedListText([
                                    'Make sure that all words are spelled correctly.',
                                    'Try different keywords or Try more general keywords.',
                                    'Try fewer keywords.'
                                  ])
                                ],
                              ),
                            );
                          }
                          // Loading Events ------------------------------------
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
