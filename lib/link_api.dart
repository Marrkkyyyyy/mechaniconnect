class AppLink {
  // static String server = "http://192.168.225.197/mechaniconnect";
  static String server = "https://mechaniconnect.yfcfarmfinds.com";

  // ================================= Auth ====================================
  static String register = "$server/auth/register.php";
  static String login = "$server/auth/login.php";

  // ================================= Customer ====================================

  static String fetchCustomerService = "$server/customer/fetch_service.php";
  static String fetchCustomerCategory = "$server/customer/fetch_category.php";
  static String fetchCustomerMechanic = "$server/customer/fetch_mechanic.php";
  static String fetchCustomerRequest = "$server/customer/fetch_request.php";
  static String fetchCustomerHistory = "$server/customer/fetch_history.php";
  static String requestService = "$server/customer/request_service.php";
  static String cancelRequest = "$server/customer/cancel_request.php";

  // ================================= Admin ====================================

  // ** Mechanic
  static String fetchMechanic = "$server/admin/mechanic/fetch_mechanic.php";
  static String addMechanic = "$server/admin/mechanic/add_mechanic.php";
  static String deleteMechanic = "$server/admin/mechanic/delete_mechanic.php";
  static String updateMechanic = "$server/admin/mechanic/update_mechanic.php";

  // ** Category
  static String fetchCategory = "$server/admin/category/fetch_category.php";
  static String addCategory = "$server/admin/category/add_category.php";
  static String manipulateCategoryStatus =
      "$server/admin/category/manipulate_category_status.php";
  static String updateCategory = "$server/admin/category/update_category.php";

  // ** Service
  static String fetchService = "$server/admin/service/fetch_service.php";
  static String addService = "$server/admin/service/add_service.php";
  static String manipulateServiceStatus =
      "$server/admin/service/manipulate_service_status.php";
  static String updateService = "$server/admin/service/update_service.php";

  // ** Request
  static String fetchRequest = "$server/admin/request/fetch_request.php";
  static String fetchHistory = "$server/admin/request/fetch_history.php";
  static String confirmRequest = "$server/admin/request/confirm_request.php";
  static String doneRequest = "$server/admin/request/done_request.php";
}
