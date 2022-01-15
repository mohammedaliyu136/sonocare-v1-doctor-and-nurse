class AppConstants {

  static const String APP_NAME = 'Nurse App';

  static const String BASE_URL = 'https://sonocare.app';

  static const String REGISTER_USER_DOCTOR = '/api/DoctorRegistration';
  static const String DOCTOR_EMAIL_VERIFICATION = '/api/doctorverifyemail';
  static const String LOGIN_URI_DOCTOR = '/api/doctorlogin';
  static const String CUSTOMER_INFO_URI_DOCTOR = '/api/getDoctorProfile';
  static const String UPDATE_PROFILE_URI_DOCTOR = '/api/updateDoctorProfile';
  static const String UPDATE_VITAL_SIGN = '/api/updateVitalSign';
  static const String STATE_LIST_URI = '/api/getAllState';
  static const String LGA_LIST_URI = '/api/getLGAByStateID?state_id=';

  static const String GET_TRANSACTION_HISTORY = '/api/doctransactions';

  static const String SET_CONSULTATION_FEE = '/api/setConsultationFee?token=';
  static const String GET_APPOINTMENTS = '/api/getAlAppointments?token=';
  static const String GET_PATIENT_DETAIL = '/api/dgetPatientProfile';
  static const String GET_APPOINTMENT_DETAIL = '/api/getAppointmentID?token=';
  static const String ACCEPT_APPOINTMENTS = '/api/AcceptAppointmentment?token=';
  static const String DECLINE_APPOINTMENTS = '/api/DeclineAppointmentment?token=';
  static const String GET_SCHEDULE = '/api/getSchedule?token=';
  static const String SET_SCHEDULE = '/api/setSchedule?token=';
  static const String UPDATE_SCHEDULE = '/api/updateschedule?token=';
  static const String DELETE_SCHEDULE = '/api/deleteSchedule?token=';

  static const String DOCTOR_GET_REVIEWS = '/api/docreviews?token=';
  static const String NURSE_GET_REVIEWS = '/api/nurse_reviews?token=';
  static const String DOCTOR_UPDATE_ACCOUNT_INFO = '/api/update_doctor_account?token=';
  static const String NURSE_UPDATE_ACCOUNT_INFO = '/api/update_account?token=';
  static const String DOCTOR_WITHDRAW_FUNDS = '/api/doc_withdrawal?token=';
  static const String NURSE_WITHDRAW_FUNDS = '/api/nurse_withdrawal?token=';

  static const String SET_PRESCRIPTION = '/api/prescription?token=';
  static const String SUB_LAB_TEST_CATEGORY = '/api/lab/labsub_cat';
  static const String LAB_TEST_CATEGORY = '/api/lab/labcategory';

  static const String CUSTOMER_INFO_DOCTOR_UPDATE = '/api/updateDoctorProfile?token=';

  static const String SERVICE_PREFERENCE_LIST_URI = '/api/preferences';

  static const String TOKEN = 'token';

  static const appId = "da2e58ec2ef84ca29aa5d23c7523fb82";
  static const vid_chat_token =
      "006da2e58ec2ef84ca29aa5d23c7523fb82IAD8wY/rum5FywzQ1lh/Z8QAB8ykJk6j2wg992nfED8iwmaqFhgAAAAAEABSSZ5eU7w3YQEAAQBSvDdh";

}
