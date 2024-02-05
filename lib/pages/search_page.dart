import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/pages/detail_page.dart';
import 'package:movei_app/widgets/Search_service.dart';
import 'package:movei_app/widgets/genre_list.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<search> _searchResults = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
  expandedHeight: 120.0,
  floating: false,
  pinned: false,
  backgroundColor: Colors.black,
  flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Container(
        height: 30.0,
        width: 300.0,
        child: TextField(
          controller: _textEditingController,
          onChanged: (query) {
            _searchMovies(query);
          },
          decoration: InputDecoration(
            hintText: 'Search Movies',
            hintStyle: TextStyle(fontSize: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.black), // Set border color
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey), // Set focused border color
            ),
            prefixIcon: Icon(Icons.search_rounded, size: 22),
            labelText: 'Search',
            labelStyle: TextStyle(fontSize: 10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    ),
  ),
),

          ];
        },
        body: _textEditingController.text.isEmpty
            ? fetchGenre(context)
            : _buildSearchResults(),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopRatedDetails(
                  movieId: _searchResults[index].id,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_searchResults[index].poster_path != null &&
                    _searchResults[index].poster_path.isNotEmpty)
                  Image.network(
                    'https://image.tmdb.org/t/p/w500/${_searchResults[index].poster_path}',
                    height: 150,
                  )
                else
                  Container(
                    height: 150,
                    width: 103,
                    color: Colors.grey,
                    child: const Center(
                      child: Text('no result found'),
                    ),
                  ),
                SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                      _searchResults[index].title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _searchMovies(String query) async {
    final results = await serachmethod(query);
    setState(() {
      _searchResults = results;
    });
    _searchResults.removeWhere((movie) => movie.poster_path == null);
  }
}
