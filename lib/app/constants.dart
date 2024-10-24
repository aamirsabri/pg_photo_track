class Constant {
  static const String baseUrl = "http://117.205.3.45:8082";
  // static const String testBaseUrl = "https://kasiri.mocklab.io";
  // static const String testBaseUrl = "https://tech.mocklab.io";
  static const String testBaseUrl = "https://y163z.wiremockapi.cloud";
  static const String registration = "/attendance_register.php";
  static const String getAllCompanies =
      "/attendance_register_get_all_companies.php";
  static const String login = "/attendance_login.php";
  static const String getHolidayList = "/attendance_get_holidays.php";
  static const String getDashBoardData = "/attendance_dashboard.php";
  static const String punch = "/attendance_punch.php";
  static const String timebar = "/attendance_timebar.php";
  static const String attendanceSummeryCount = "/attendance_summery_count.php";
  static const String userDetail = "/attendance_get_user.php";
  static const String applyRegularization = "/attendance_apply_regularization";
  static const String applyLeave = "/attendance_apply_leave.php";
  static const String userPendingRequests =
      "/attendance_user_pending_requests.php";
  static const String userPastRequests = "/attendance_user_past_requests.php";
  static const String getRequestDetail = "/attendance_get_request_detail.php";
  static const String cancelRequest = "/attendance_cancel_request.php";
  static const String getAdminTodayStatusReport =
      "/attendance_admin_get_user_list.php";
  static const String getAdminUserwiseAttendanceSummery =
      "/attendance_admin_get_userwise_attendance_summery.php";
  static const String getLocationByAdminLocations =
      "/attendance_admin_get_locations.php";
  static const String getAdminPastApproval =
      "/attendance_admin_past_approval.php";
  static const String getAdminPendingApproval =
      "/attendance_admin_pending_approval.php";
  static const String getAdminTodayPunchCount =
      "/attendance_admin_today_punch_count.php";
  static const String getAdminCurrentMonthCount =
      "/attendance_admin_current_month_count.php";
  static const String updateAdminRequest =
      "/attendance_admin_update_request_status.php";
  static const String updateImeiRequest = "/attendance_update_imei_request.php";
  static const String createAnnouncement =
      "/attendance_admin_create_announcement.php";

  static const String testGetCompanyIds = "/getAllCompanyCodes";
  // static const String testLogin = "/rdss/login";
  // static const String testRegister = "/rdss/register";

  static const String testUpdateIMEI = "/rdss/updateIMEI";
  // static const String testDashboard = "/rdss/dashboard";
  static const String testPunch = "/rdss/punchRequest";
  static const String testAdminPastApproval = "/rdss/admin_past_approvals";
  // static const String testAttendanceSummery = "/rdss/getAttendanceSummery";

  // static const String testAttendanceSummeryCount =
  //     "/rdss/attendance_summery_count";
  static const String testRegularizeReasons = "/rdss/getRegularizationReasons";
  // static const String testApplyRegularization = "/rdss/applyRegularization";
  // static const String testUserDetail = "/rdss/getUserDetail";
  static const String testPendingRequest = "/rdss/getPendingRequests";
  // static const String testHistoryRequest = "/rdss/getHistoryRequest";
  static const String testGetRequestDetail = "/rdss/getRequestDetail";
  static const String testCancleRequest = "/rdss/cancleRequest";
  // static const String testApplyLeave = "/rdss/applyLeave";
  // static const String testGetAbsentUsers = "/rdss/getAbsentUserList";
  static const String testAdminPendingApprovals =
      "/rdss/admin/pending_approvals";
  static const String testRequestStatusUpdate = "/rdss/request_status_update";
  static const String testAdminUserWiseAttendanceSummery =
      "/rdss/adminUserWiseAttendanceSummery";
  static const String testGetLocations = "/rdss/getLocationsByLocation";
}

const INCLUDE_SUB_LOCATIONS = 1;
const DONT_INCLUDE_SUB_LOCATIONS = 0;

const INCLUDE_PARENT_LOCATION = 1;
const DONT_INCLUDE_PARENT_LOCATION = 0;

const String EMPTY = "";
const int ZERO = 0;

enum SELECTED_LEAVE_TYPE { FULL_DAY, FIRST_HALF, SECOND_HALF }
