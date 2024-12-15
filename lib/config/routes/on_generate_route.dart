import 'package:flutter/cupertino.dart';
import 'package:link_level_up/config/routes/unknown_page.dart';

import '../../components/SettingPages.dart';
import '../../components/my_appointments.dart';
import '../../features/athlete/community/community_create_post_screen.dart';
import '../../features/athlete/community/community_post_comment_screen.dart';
import '../../features/athlete/community/community_profile_screen.dart';
import '../../features/athlete/community/community_screen.dart';
import '../../features/athlete/home/athlete_home.dart';
import '../../features/athlete/home/athlete_main.dart';
import '../../features/athlete/home/athlete_profile.dart';
import '../../features/athlete/message/chat_screen.dart';
import '../../features/athlete/message/message_screen.dart';
import '../../features/athlete/notification/notification_page.dart';
import '../../features/athlete/privacy_policy/help_center_screen.dart';
import '../../features/athlete/privacy_policy/privacy_policy_screen.dart';
import '../../features/athlete/profile/add_age_page_old.dart';
import '../../features/athlete/profile/add_height_page.dart';
import '../../features/athlete/profile/add_location_page.dart';
import '../../features/athlete/profile/add_weight_page.dart';
import '../../features/athlete/profile/athlete_profile_details.dart';
import '../../features/athlete/profile/gender_selection_page.dart';
import '../../features/athlete/profile/level_selection_page.dart';
import '../../features/athlete/profile/sports_selection_page.dart';
import '../../features/athlete/profile/trainer/add_trainer_certificate_page.dart';
import '../../features/athlete/profile/trainer/add_trainer_education_page.dart';
import '../../features/athlete/profile/trainer/add_trainer_experience_page.dart';
import '../../features/athlete/profile/trainer/add_trainer_working_hour_page.dart';
import '../../features/auth/presentation/pages/childern_selection_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/new_password_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/start_page.dart';
import '../../features/auth/presentation/pages/user_type_selection_screen.dart';
import '../../features/facilitator/add_facility.dart';
import '../../features/facilitator/create_new_session.dart';
import '../../features/facilitator/facilitator_details_for_user.dart';
import '../../features/facilitator/facilitator_main.dart';
import '../../features/facilitator/facility_details.dart';
import '../../features/facilitator/facility_profile_details.dart';
import '../../features/facilitator/session_details.dart';
import '../../features/parent/add_children_page.dart';
import '../../features/parent/home/athlete_main_parent.dart';
import '../../features/payment/add_card.dart';
import '../../features/payment/payment_congratulations.dart';
import '../../features/payment/payment_method.dart';
import '../../features/payment/payment_receipt.dart';
import '../../features/payment/payment_review_summary.dart';
import '../../features/tariner/edit_trainer_education.dart';
import '../../features/tariner/edit_trainer_education_list.dart';
import '../../features/tariner/edit_trainer_experience.dart';
import '../../features/tariner/edit_trainer_experience_list.dart';
import '../../features/tariner/edit_trainer_profile.dart';
import '../../features/tariner/request_athlete_details.dart';
import '../../features/tariner/trainer_details_for_user.dart';
import '../../features/tariner/trainer_home.dart';
import '../../features/tariner/trainer_main.dart';
import '../../features/tariner/trainer_profile_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.signup:
        return CupertinoPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.forgotPassword:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordPage());
      case AppRoutes.OtpPage:
        return CupertinoPageRoute(builder: (_) => const OtpPage());
      case AppRoutes.passwordReset:
        return CupertinoPageRoute(builder: (_) => const NewPasswordPage());
      case AppRoutes.userTypeSelection:
        return CupertinoPageRoute(
            builder: (_) => const UserTypeSelectionScreen());
      case AppRoutes.GenderSelectionPage:
        return CupertinoPageRoute(builder: (_) => const GenderSelectionPage());
      case AppRoutes.SportsSelectionPage:
        return CupertinoPageRoute(builder: (_) => const SportsSelectionPage());
      case AppRoutes.LevelSelectionPage:
        return CupertinoPageRoute(builder: (_) => const LevelSelectionPage());
      case AppRoutes.AgeSelectionPage:
        return CupertinoPageRoute(builder: (_) => const AgeSelectionPage());
      case AppRoutes.HeightSelectionPage:
        return CupertinoPageRoute(builder: (_) => const HeightSelectionPage());
      case AppRoutes.WeightSelectionPage:
        return CupertinoPageRoute(builder: (_) => const WeightSelectionPage());
      case AppRoutes.AddLocationPage:
        return CupertinoPageRoute(builder: (_) => const AddLocationPage());
      case AppRoutes.AthleteMainPage:
        return CupertinoPageRoute(builder: (_) => const AthleteMainPage());
      case AppRoutes.AthleteHomePage:
        return CupertinoPageRoute(builder: (_) => const AthleteHomePage());
      case AppRoutes.AthleteProfile:
        return CupertinoPageRoute(builder: (_) => const AthleteProfile());
      case AppRoutes.AthleteProfileDetails:
        return CupertinoPageRoute(
            builder: (_) => const AthleteProfileDetails());
      case AppRoutes.NotificationsScreen:
        return CupertinoPageRoute(builder: (_) => const NotificationsScreen());
      case AppRoutes.TrainerDetailsPageForUser:
        return CupertinoPageRoute(
            builder: (_) => const TrainerDetailsPageForUser());
      case AppRoutes.FacilitatorDetailsForUser:
        return CupertinoPageRoute(
            builder: (_) => const FacilitatorDetailsForUser());
      case AppRoutes.PaymentMethod:
        return CupertinoPageRoute(builder: (_) => const PaymentMethod());
      case AppRoutes.AddCard:
        return CupertinoPageRoute(builder: (_) => const AddCard());
      case AppRoutes.PaymentReviewSummary:
        return CupertinoPageRoute(builder: (_) => const PaymentReviewSummary());
      case AppRoutes.PaymentReceipt:
        return CupertinoPageRoute(builder: (_) => const PaymentReceipt());
      case AppRoutes.PaymentCongratulations:
        return CupertinoPageRoute(
            builder: (_) => const PaymentCongratulations());
      case AppRoutes.AthleteMainPageParent:
        return CupertinoPageRoute(
            builder: (_) => const AthleteMainPageParent());
      case AppRoutes.TrainerHomePage:
        return CupertinoPageRoute(builder: (_) => const TrainerHomePage());
      case AppRoutes.StartScreen:
        return CupertinoPageRoute(builder: (_) => const StartScreen());
      case AppRoutes.AthleteCommunity:
        return CupertinoPageRoute(builder: (_) => const CommunityScreen());
      case AppRoutes.AthleteCommunityProfile:
        return CupertinoPageRoute(
            builder: (_) => const CommunityProfileScreen());
      case AppRoutes.AthleteCommunityCreatePost:
        return CupertinoPageRoute(
            builder: (_) => const CommunityCreatePostScreen());
      case AppRoutes.AthleteCommunityPostComment:
        return CupertinoPageRoute(builder: (_) => CommunityPostCommentScreen());
      case AppRoutes.AthleteMessage:
        return CupertinoPageRoute(builder: (_) => MessagesScreen());
      case AppRoutes.AthleteChat:
        return CupertinoPageRoute(builder: (_) => ChatScreen());
      case AppRoutes.AthletePrivacyPolicy:
        return CupertinoPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case AppRoutes.AthleteHelpCenter:
        return CupertinoPageRoute(builder: (_) => const HelpCenterScreen());
      case AppRoutes.FacilitatorProfile:
        return CupertinoPageRoute(builder: (_) => const EditTrainerProfile());
      case AppRoutes.TrainerMain:
        return CupertinoPageRoute(builder: (_) => const TrainerMain());
      case AppRoutes.RequestAthleteDetails:
        return CupertinoPageRoute(
            builder: (_) => const RequestAthleteDetails());
      case AppRoutes.PrivacyPolicyScreen:
        return CupertinoPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case AppRoutes.FacilitatorMain:
        return CupertinoPageRoute(builder: (_) => const FacilitatorMain());
      case AppRoutes.SessionDetailsPage:
        return CupertinoPageRoute(builder: (_) => const SessionDetailsPage());
      case AppRoutes.CreateNewSessionPage:
        return CupertinoPageRoute(builder: (_) => const CreateNewSessionPage());
      case AppRoutes.SettingsPage:
        return CupertinoPageRoute(builder: (_) => const SettingsPage());
      case AppRoutes.MyAppointmentPage:
        return CupertinoPageRoute(builder: (_) => const MyAppointmentPage());
      case AppRoutes.AddChildrenPage:
        return CupertinoPageRoute(builder: (_) => const AddChildrenPage());
      case AppRoutes.FacilityProfileDetails:
        return CupertinoPageRoute(
            builder: (_) => const FacilityProfileDetails());
      case AppRoutes.FacilityDetails:
        return CupertinoPageRoute(builder: (_) => const FacilityDetails());
      case AppRoutes.FacilitatorDetailsPage:
        return CupertinoPageRoute(
            builder: (_) => const FacilitatorDetailsPage());
      case AppRoutes.TrainerProfilePage:
        return CupertinoPageRoute(builder: (_) => const TrainerProfilePage());
      case AppRoutes.EditTrainerProfile:
        return CupertinoPageRoute(builder: (_) => const EditTrainerProfile());
      case AppRoutes.EditTrainerExperienceList:
        return CupertinoPageRoute(
            builder: (_) => const EditTrainerExperienceList());
      case AppRoutes.EditTrainerExperience:
        return CupertinoPageRoute(
            builder: (_) => const EditTrainerExperience());
      case AppRoutes.EditTrainerEducation:
        return CupertinoPageRoute(builder: (_) => const EditTrainerEducation());
      case AppRoutes.EditTrainerEducationList:
        return CupertinoPageRoute(
            builder: (_) => const EditTrainerEducationList());
      case AppRoutes.AddTrainerWorkingHourPage:
        return CupertinoPageRoute(
            builder: (_) => const AddTrainerWorkingHourPage());
      case AppRoutes.AddTrainerExperiencePage:
        return CupertinoPageRoute(
            builder: (_) => const AddTrainerExperiencePage());
      case AppRoutes.AddTrainerCertificatePage:
        return CupertinoPageRoute(
            builder: (_) => const AddTrainerCertificatePage());
      case AppRoutes.AddTrainerEducationPage:
        return CupertinoPageRoute(
            builder: (_) => const AddTrainerEducationPage());
      case AppRoutes.ChildrenSelectionPage:
        return CupertinoPageRoute(
            builder: (_) => const ChildrenSelectionPage());

      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
