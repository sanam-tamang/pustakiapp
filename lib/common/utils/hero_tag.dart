class HeroTag {
  static String image({required String navigatedFrom, required String image}) {
    return navigatedFrom+image;
  }

  ///in the button tag we will use id of the document for unique value
  static String buttonTag({required String navigatedFrom, required String button}) {
    return navigatedFrom+button;
  }
}
