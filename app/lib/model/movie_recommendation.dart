class MovieRecommendation {
  String doubanId;
  String description;

  MovieRecommendation(this.doubanId, this.description);
  

  MovieRecommendation.fromJson(Map data) {
    doubanId = data['doubanId'];
    description = data['description'];
  }
}