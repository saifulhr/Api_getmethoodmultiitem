import 'package:api_getmethod_multipleitem/data/model/comments_page.dart';
import 'package:api_getmethod_multipleitem/data/repository/api_service.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late Future<List<Comments>>? fetchComments;
  @override
  void initState() {
    super.initState();
    fetchComments = ApiService().fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          'Comments List',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: fetchComments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Comments> comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comments[index].email,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Text(
                            comments[index].name,
                            style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 244, 6, 58),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            comments[index].body,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            );
          } else {
            return Center(
              child: Text('Comments not found'),
            );
          }
        },
      ),
    );
  }
}
