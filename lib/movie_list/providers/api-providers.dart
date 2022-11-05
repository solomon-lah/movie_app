import 'package:briskit_assignment/movie_list/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImdbApi {
  Future<List<dynamic>> movies() async {
    final endpoint =
        '${Api.IMDB_API_ENDPOINT}MostPopularTVs/${Api.IMDB_API_KEY}';
    final request = await http.get(Uri.parse(endpoint));
    final items = json.decode(request.body)['items'];
    return items;
  }

  Future<List<dynamic>> search_movies({required String movie_name}) async {
    final endpoint =
        '${Api.IMDB_API_ENDPOINT}SearchMovie/${Api.IMDB_API_KEY}/${movie_name}';

    final request = await http.get(Uri.parse(endpoint));
    final results = json.decode(request.body)['results'];
    return results;
  }

  Future<dynamic> get_movie_detail({required String movie_id}) async {
    final endpoint =
        '${Api.IMDB_API_ENDPOINT}Title/${Api.IMDB_API_KEY}/${movie_id}/Images,Trailer';

    final request = await http.get(Uri.parse(endpoint));
    final results = json.decode(request.body);
    return results;
  }
}
