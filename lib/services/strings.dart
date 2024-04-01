import 'package:projectname/widgets/string_extension.dart';

class Strings {
  //

  static const appName = 'spotter.app';
  static const appSubtitle = 'Collaborative location sharing.';
  static const roomName = 'space';

  static const privacyPolicy = 'Privacy Policy';
  static const privacyPolicyLink = 'http://www.facebook.com';
  static const appDataCollection =
      'This app collects location data to enable driving analysis, crash detection, place alerts and to share location with $roomName members. Even when the app is closed or not in use. You can learn more about our choices in our privacy policy.';

  // Onboarding
  static const whatsYourName = 'Whats your name?';
  static const youCanChangeThisLaterToo = 'You can change this later too.';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const andYourContactNumber = 'And your contact number?';
  static const veryImportantForEmergencies = 'Very important for emergencies.';
  static const maskedNumber = '09XXXXXXXXX';

  // Permissions
  static const requiresThisPermissionToWork =
      'Requires these permissions to work.';
  static const location = 'Location';
  static const locationSubtitle =
      'Share your location with\nthose in the $roomName as you.';
  static const backgroundLocation = 'Backgroud Location';
  static const backgroundLocationSubtitle =
      'Updates for location even when screen is off to save battery.';
  static const physicalActivity = 'Physical Activity';
  static const physicalActivitySubtitle =
      'Monitor car travel and driver safety.';

  // Main
  static const enterYourCode = 'Enter your code below\nor create one';
  static const sampleRoom = 'XXX-XXX';
  static const createARoom = 'Create a $roomName';
  static const sampleRoomName = 'NAME HERE';
  static final longerName = 'Name is too short.'.toCapitalized();
  static const minuteError =
      'For minutes, minimum is 10 & maximum is 60 minutes.';
  static const hourError = 'For hours, minimum is 1 & maximum is 24 hours.';
  static const dayError = 'For days, minimum is 1 & maximum is 3 days.';
  static const changeSettings = 'Change Settings';
  static const expiresAfter = 'Expires after';
  static const minutes = 'MINUTES';
  static const hours = 'HOURS';
  static const days = 'DAYS';
  static const setAreaNotifs = 'Set Area Notifications';
  static const setAreaNotifsSubtitle =
      'Notifies if a person steps into an area.\n(Please contact admin to setup.)';
  static const beta = 'Beta';
  static const creatingRoom = 'Creating $roomName';
  static const joiningRoom = 'Joining $roomName';
  static const leavingRoom = 'Leaving $roomName';
  static const joiningLastRoom = 'Rejoining previous $roomName';
  static const pleaseWait = 'Please wait';
  static const inviteCodeExpired = 'Invite code is expired or not valid';
  static const inviteCodeForRoom = 'Invite Code for ';
  static const clickToCopy = 'click to copy';
  static const sessionEndsOn = 'Session Ends On';
  static const showRoomHistory = 'Show $roomName History';
  static const hideRoomHistory = 'Hide $roomName History';
  static const leaveRoom = 'Leave $roomName';

  // Notifications
  static const initialNotesOnStart =
      'By default, you are not visible in the map. Click the eye icon to be seen.';
  static const yourAreVisible =
      'You are now visible to everyone in the $roomName';

  // Buttons
  static const startNowButton = 'Start Now';
  static const continueButton = 'Continue';
  static const enableButton = 'Enable';
  static const enabledButton = 'Enabled';
  static const disabledButton = 'Disabled';
  static const disableButton = 'Disable';
  static const cancelButton = 'Cancel';
  static const createRoomButtonOrJoin = 'Create a $roomName or join';
  static const createButton = 'Create';

  // Social Media
  static const facebookPageLink = 'http://www.facebook.com';
}
