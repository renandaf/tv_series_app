import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series_app/common/constants.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});
  static const routeName = '/detail_series';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://www.themoviedb.org/t/p/original/b6IRp6Pl2Fsq37r9jFhGoLtaqHm.jpg"),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: kRichBlack,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: kYellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1000,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.1],
                      colors: [Colors.transparent, Colors.black],
                    ),
                  ),
                  margin: EdgeInsets.only(top: size.height * 0.37),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              "Dahmer Monster of Her",
                              style: kTitle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "2021",
                                  style: kSmall,
                                ),
                                Text(
                                  " | ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 0.25,
                                      color: kDavysGrey.withOpacity(0.5)),
                                ),
                                Text(
                                  "Crime,Horror,Action",
                                  style: kSmall,
                                ),
                                Text(
                                  " | ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 0.25,
                                      color: kDavysGrey.withOpacity(0.5)),
                                ),
                                Text(
                                  "6 Episode",
                                  style: kSmall,
                                ),
                              ],
                            ),
                            RatingBarIndicator(
                              itemPadding: EdgeInsets.symmetric(horizontal: 5),
                              rating: 4.3,
                              itemCount: 5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: kYellow,
                              ),
                              itemSize: 25,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Add to Watchlist",
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              vertical: 13, horizontal: 43)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              indent: 30,
                              endIndent: 30,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Overview",
                                  style: kH6,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.",
                                    style: kBody),
                                SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                        Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "All Episode",
                                  style: kH6,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Recommendations",
                            style: kH6,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
