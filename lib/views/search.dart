import 'package:chat_app/services/database.dart';
import 'package:chat_app/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  dynamic searchSnapshot;

  createChatroomAndStartConvo() {
    List<String> users = [
      userName,
    ];
    databaseMethods.createChatRoom();
  }

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.docs[index]["name"],
                userEmail: searchSnapshot.docs[index]["email"],
              );
            })
        : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: appBarMain(context),
      ),
      body: Container(
        child: Column(children: [
          Container(
            color: const Color(0x54FFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search UserName...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/images/search_white.png')),
                )
              ],
            ),
          ),
          searchList()
        ]),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchTile({required this.userName, required this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: simpleTextStyle(),
              ),
              Text(
                userEmail,
                style: simpleTextStyle(),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Message",
                  style: simpleTextStyle(),
                )),
          )
        ],
      ),
    );
  }
}
