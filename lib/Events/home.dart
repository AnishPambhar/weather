import 'package:flutter/material.dart';

class EventHomePage extends StatelessWidget {
  final List<String> categories = [
    "Music",
    "Concerts",
    "Sports",
    "Art",
    "Tech"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Home Page',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(height: 55,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search for events...',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xffe9e9e9)),
                ),
              ),
            ),

            // Categories
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 40.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Chip(
                          label: Text(
                            categories[index],
                            style: TextStyle(color: Colors.black),
                          ),
                          avatar: Icon(Icons.category),
                          backgroundColor: Colors.white,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          elevation: 1,
                          shadowColor: Colors.grey,side: BorderSide.none, ),
                    );
                  },
                ),
              ),
            ),
            // Upcoming Events
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle('Upcoming Events'),
                Text(
                  "See All",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff808080)),
                )
              ],
            ),
            Container(
              height: 200.0,
              width: 20,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  "assets/1.png",
                                )),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Event $index 2023",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(width: 8),
                                          Text(
                                            "Surat",
                                            style: TextStyle(
                                              color: Color(0xff8b8688),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xff808080),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Join", // Change "Join" to your desired text
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Popular Events
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SectionTitle('Popular Events'),
            //     Text(
            //       "See All",
            //       style: TextStyle(
            //           fontWeight: FontWeight.w700,
            //           fontSize: 16,
            //           color: Color(0xff808080)),
            //     )
            //   ],
            // ),
// Popular EventsS

          SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle('Popular Events'),
                Text(
                  "See All",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff808080),
                  ),
                )
              ],
            ),
   // Add some space between title and content
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 300.0,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/logo.png'), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffa5a2b2)),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "Dance", // Change "Join" to your desired text
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Event $index 2023",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      SizedBox(width: 8),
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                          color: Color(0xff8b8688),
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      color: Color(0xffcccccc),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "30.00",
                                        style: TextStyle(
                                          color: Color(0xff808080),
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )

                              // Add more details as needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Recommendations for You
            SectionTitle('Recommendations for You'),
            Container(
              height: 200.0,
              width: 20,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  "assets/2.png",
                                )),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Event $index 2023",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(width: 8),
                                          Text(
                                            "Surat",
                                            style: TextStyle(
                                              color: Color(0xff8b8688),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xffcccccc),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "250.00", // Change "Join" to your desired text
                                            style: TextStyle(
                                              color: Color(0xff808080),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatefulWidget {
  final String category;

  CategoryChip(this.category);

  @override
  _CategoryChipState createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(widget.category),
      avatar: Icon(Icons.category),
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Remove padding
      elevation: 0, // Remove shadow
    );
  }
}

class SectionTitle extends StatefulWidget {
  final String title;

  SectionTitle(this.title);

  @override
  _SectionTitleState createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        widget.title,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            fontFamily: "Montserrat"),
      ),
    );
  }
}
