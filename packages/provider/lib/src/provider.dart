import 'package:app_provider/app_provider.dart';
import 'package:app_provider/src/cubit/quantity/counter_cubit.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:isumi/auth.dart';
import 'package:isumi/core/routes/page_route.dart';
import 'package:remote_data/remote_data.dart';
// import 'package:isumi/app/screens/auth.dart';
// import 'package:isumi/core/routes/page_route.dart';
import 'bloc/app_bloc.dart';
import 'theme/app_theme.dart';
import 'theme/cubit/theme_cubit.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({Key? key, required AuthRepository authRepo})
      : _authRepo = authRepo;

  final AuthRepository _authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
          // BlocProvider<ConnectedBloc>(create: (context) => ConnectedBloc()),
          BlocProvider<AppBloc>(create: (_) => AppBloc(authRepo: _authRepo)),
          // BlocProvider<SellerCubit>(create: (context) => SellerCubit()),
          BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => DrawerProvider()),
            ChangeNotifierProvider(create: (_) => Validation()),
            ChangeNotifierProvider(create: (_) => NotificationBadge()),
            ChangeNotifierProvider(create: (_) => SelectedList()),
          ],
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appstate) {
              return Sizer(child: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return KeyboardUnfocus(
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Isumi',
                      theme: AppTheme.themeData(state.isDarkThemeOn, context),
                      home: WapperPage(state: appstate.status),
                      onGenerateRoute: (settings) =>
                          RouteGenerator.generateRoute(settings),
                    ),
                  );
                },
              ));
            },
          ),
        ),
      ),
    );
  }
}
