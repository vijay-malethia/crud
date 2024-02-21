import 'package:crud/services/databasemethods_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

/// @stacked-import
import 'package:crud/ui/views/home/home_view.dart';
import 'package:crud/ui/views/startup/startup_view.dart';
import 'package:crud/ui/views/auth/auth_view.dart';
import 'package:crud/ui/views/otp/otp_view.dart';
import 'package:crud/ui/bottom_sheets/add_edit_item/add_edit_item_sheet.dart';

@StackedApp(
  // @stacked-route
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: OtpView),
  ],

  // @stacked-service
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabasemethodsService),
  ],

  // @stacked-bottom-sheet
  bottomsheets: [
    StackedBottomsheet(classType: AddEditItemSheet),
  ],

  // @stacked-dialog
  dialogs: [],
)
class App {}
