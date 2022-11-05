import 'package:cloud_firestore/cloud_firestore.dart';

//User model,
class User {
  String username, password;
  User({required this.username, required this.password});

  factory User.formCloudStore(QueryDocumentSnapshot queryDocumentSnapshot) {
    return User(
        username: queryDocumentSnapshot['username'],
        password: queryDocumentSnapshot['password']);
  }
}

//Movie Model
class Movie {
  String title, id, description, image;
  Movie({
    required this.title,
    required this.id,
    required this.description,
    required this.image,
  });

  factory Movie.fromImbdApiJson(Map<String, dynamic> movieFromImdbApi) {
    return Movie(
        title: movieFromImdbApi['title'],
        id: movieFromImdbApi['id'],
        description: movieFromImdbApi['year'],
        image: movieFromImdbApi['image']);
  }

  factory Movie.fromImbdApiSearchJson(Map<String, dynamic> movieFromImdbApi) {
    return Movie(
        title: movieFromImdbApi['title'],
        id: movieFromImdbApi['id'],
        description: movieFromImdbApi['description'],
        image: movieFromImdbApi['image']);
  }
  @override
  String toString() {
    return this.title;
  }
}

//Actor List Model
class ActorList {
  String id;
  String image;
  String name;
  String asCharacter;
  ActorList({
    required this.id,
    required this.image,
    required this.name,
    required this.asCharacter,
  });

  factory ActorList.fromJson(Map<String, dynamic> json) => ActorList(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        asCharacter: json["asCharacter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "asCharacter": asCharacter,
      };
}

//Movie Images Model
class Images {
  Images({
    required this.imDbId,
    required this.title,
    required this.fullTitle,
    required this.type,
    required this.year,
    required this.items,
    required this.errorMessage,
  });

  String imDbId;
  String title;
  String fullTitle;
  String type;
  String year;
  List<Item> items;
  String errorMessage;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        imDbId: json["imDbId"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "imDbId": imDbId,
        "title": title,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

//Movie Items Model
class Item {
  Item({
    required this.title,
    required this.image,
  });

  String title;
  String image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
      };
}

//Movie Trailer Model
class Trailer {
  Trailer({
    required this.imDbId,
    required this.title,
    required this.fullTitle,
    required this.type,
    required this.year,
    required this.videoId,
    required this.videoTitle,
    required this.videoDescription,
    required this.thumbnailUrl,
    required this.uploadDate,
    required this.link,
    required this.linkEmbed,
    required this.errorMessage,
  });

  String imDbId;
  String title;
  String fullTitle;
  String type;
  String year;
  String videoId;
  String videoTitle;
  String videoDescription;
  String thumbnailUrl;
  String uploadDate;
  String link;
  String linkEmbed;
  String errorMessage;

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        imDbId: json["imDbId"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        videoId: json["videoId"],
        videoTitle: json["videoTitle"],
        videoDescription: json["videoDescription"],
        thumbnailUrl: json["thumbnailUrl"],
        uploadDate: json["uploadDate"],
        link: json["link"],
        linkEmbed: json["linkEmbed"],
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "imDbId": imDbId,
        "title": title,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "videoId": videoId,
        "videoTitle": videoTitle,
        "videoDescription": videoDescription,
        "thumbnailUrl": thumbnailUrl,
        "uploadDate": uploadDate,
        "link": link,
        "linkEmbed": linkEmbed,
        "errorMessage": errorMessage,
      };
}

//Movie Detail Model
class MovieDetail {
  MovieDetail(
      {required this.id,
      required this.title,
      required this.originalTitle,
      required this.fullTitle,
      required this.type,
      required this.year,
      required this.image,
      required this.releaseDate,
      required this.plot,
      required this.stars,
      required this.actorList,
      required this.genres,
      required this.countries,
      required this.contentRating,
      required this.images,
      required this.trailer,
      required this.directors,
      required this.writers,
      this.errorMessage,
      required this.languages});

  String id;
  String title;
  String originalTitle;
  String fullTitle;
  String type;
  String year;
  String image;
  DateTime releaseDate;
  String plot;
  String directors;
  String writers;
  String stars;
  List<ActorList> actorList;
  dynamic fullCast;
  String genres;
  String countries;
  String languages;
  String contentRating;
  Images images;
  Trailer trailer;
  dynamic errorMessage;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        id: json["id"],
        title: json["title"],
        originalTitle: json["originalTitle"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        image: json["image"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        plot: json["plot"],
        writers: json["writers"],
        stars: json["stars"],
        actorList: List<ActorList>.from(
            json["actorList"].map((x) => ActorList.fromJson(x))),
        genres: json["genres"],
        countries: json["countries"],
        languages: json["languages"],
        contentRating: json["contentRating"],
        images: Images.fromJson(json["images"]),
        trailer: Trailer.fromJson(json["trailer"]),
        errorMessage: json["errorMessage"],
        directors: json["directors"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "originalTitle": originalTitle,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "image": image,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "plot": plot,
        "directors": directors,
        "writers": writers,
        "genres": genres,
        "countries": countries,
        "languages": languages,
        "contentRating": contentRating,
        "images": images.toJson(),
        "trailer": trailer.toJson(),
        "errorMessage": errorMessage,
      };
}

class MovieDetailParams {
  String id, title;
  MovieDetailParams({required this.id, required this.title});
}
