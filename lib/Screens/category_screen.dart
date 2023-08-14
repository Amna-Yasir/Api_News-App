import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/Category_channel_model.dart';
import 'package:news_app/view_model/CategoryViewModel.dart';

class category_screen extends StatefulWidget {
  const category_screen({super.key});

  @override
  State<category_screen> createState() => _category_screenState();
}

class _category_screenState extends State<category_screen> {
  final format = DateFormat('MMMM dd, yyyy');
  String categoryname = 'general';
  CategoryViewModel categoryViewModel = CategoryViewModel();
  List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  itemCount: categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryname = categoryList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: categoryname == categoryList[index]
                                  ? Colors.blue
                                  : const Color.fromARGB(255, 201, 197, 197),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                              categoryList[index].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<category_channel_model>(
                  future: categoryViewModel
                      .fetchCategoryApiIntegeration(categoryname),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCube(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
