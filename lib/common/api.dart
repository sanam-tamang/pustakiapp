const String baseUrl = 'https://pustakidjapp-production.up.railway.app';
// const String baseUrl = 'http://sanam.pythonanywhere.com';
// const String baseUrl = "http://127.0.0.1:8000";

const String registrationUrl = '$baseUrl/user/register/';
const String loginUrl = '$baseUrl/user/login/';
const String userDetailUrl = '$baseUrl/user/detail/';

const String refreshTokenUrl = '$baseUrl/api/token/refresh/';

const String addBookUrl = '$baseUrl/book/add/';
const String bookListUrl = '$baseUrl/book/list_book/';

///To get the category related book you also need to pass the id of category meaning that
///baseUrl/book/category/categoryid like this note do't forget to add category id at the end of this
///  [bookListWithCategoryUrl] with category id
const String bookListWithCategoryUrl = '$baseUrl/book/category/';

///we need to pass user id to get the data from this [bookListWithUserUrl]
const String bookListWithUserUrl = '$baseUrl/book/user/';


const String categoryListUrl = '$baseUrl/category/list_category/';

///in this url only admin is able to add the category of the book meaning that when
///we need we category this is added by admin
const String addCategoryUrl = '$baseUrl/category/add/';
