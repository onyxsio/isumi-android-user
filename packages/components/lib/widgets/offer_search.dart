import 'package:components/components.dart';
import 'package:flutter/material.dart';

//
Future<T?> productsOffers<T>({
  required BuildContext context,
  required OfferDeleg<T> delegate,

  // required List selectedItems,
  String? query = '',
  autoFocus = false,
}) {
  delegate.query = query ?? delegate.query;
  // delegate.selectedList = selectedItems;
  delegate._currentBody = _OfferSearchBody.suggestions;
  return Navigator.of(context, rootNavigator: false)
      .push(_OfferSearchPageRoute<T>(delegate: delegate));
}

abstract class OfferDeleg<T> {
  OfferDeleg({
    this.searchFieldLabel,
    this.searchFieldStyle,
    this.searchFieldDecorationTheme,
    this.textInputAction = TextInputAction.search,
  }) : assert(searchFieldStyle == null || searchFieldDecorationTheme == null);

  Widget buildSuggestions(BuildContext context);

  Widget buildResults(BuildContext context);

  Widget buildFilter(BuildContext context);

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  String get query => _queryTextController.text;

  set query(String value) {
    _queryTextController.text = value;
    _queryTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: _queryTextController.text.length));
  }

  void showResults(BuildContext context) {
    _focusNode?.unfocus();
    _currentBody = _OfferSearchBody.results;
  }

  void showSuggestions(BuildContext context) {
    assert(_focusNode != null,
        '_focusNode must be set by route before showSuggestions is called.');
    _focusNode!.requestFocus();
    _currentBody = _OfferSearchBody.suggestions;
  }

  void close(BuildContext context, T result) {
    _currentBody = null;
    _focusNode?.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == _route)
      ..pop(result);
  }

  final String? searchFieldLabel;

  final TextStyle? searchFieldStyle;

  final InputDecorationTheme? searchFieldDecorationTheme;

  final TextInputAction textInputAction;

  Animation<double> get transitionAnimation => _proxyAnimation;

  FocusNode? _focusNode;

  final TextEditingController _queryTextController = TextEditingController();

  final ProxyAnimation _proxyAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  final ValueNotifier<_OfferSearchBody?> _currentBodyNotifier =
      ValueNotifier<_OfferSearchBody?>(null);

  _OfferSearchBody? get _currentBody => _currentBodyNotifier.value;
  set _currentBody(_OfferSearchBody? value) {
    _currentBodyNotifier.value = value;
  }

  _OfferSearchPageRoute<T>? _route;
}

enum _OfferSearchBody { suggestions, results }

class _OfferSearchPageRoute<T> extends PageRoute<T> {
  _OfferSearchPageRoute({required this.delegate}) {
    assert(
      delegate._route == null,
      'The ${delegate.runtimeType} instance is currently used by another active '
      'search. Please close that search by calling close() on the SearchDelegate '
      'before opening another search with the same delegate instance.',
    );
    delegate._route = this;
  }

  final OfferDeleg<T> delegate;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 10);

  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Animation<double> createAnimation() {
    final Animation<double> animation = super.createAnimation();
    delegate._proxyAnimation.parent = animation;
    return animation;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _OfferSearchPage<T>(delegate: delegate, animation: animation);
  }

  @override
  void didComplete(T? result) {
    super.didComplete(result);
    assert(delegate._route == this);
    delegate._route = null;
    delegate._currentBody = null;
  }
}

class _OfferSearchPage<T> extends StatefulWidget {
  const _OfferSearchPage({required this.delegate, required this.animation});

  final OfferDeleg<T> delegate;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() => _OfferSearchPageState<T>();
}

class _OfferSearchPageState<T> extends State<_OfferSearchPage<T>> {
  // This node is owned, but not hosted by, the search page. Hosting is done by
  // the text field.
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.delegate._queryTextController.addListener(_onQueryChanged);
    widget.animation.addStatusListener(_onAnimationStatusChanged);
    widget.delegate._currentBodyNotifier.addListener(_onSearchBodyChanged);
    focusNode.addListener(_onFocusChanged);
    widget.delegate._focusNode = focusNode;
  }

  @override
  void dispose() {
    super.dispose();
    widget.delegate._queryTextController.removeListener(_onQueryChanged);
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    widget.delegate._currentBodyNotifier.removeListener(_onSearchBodyChanged);
    widget.delegate._focusNode = null;
    focusNode.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    if (widget.delegate._currentBody == _OfferSearchBody.suggestions) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(_OfferSearchPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.delegate != oldWidget.delegate) {
      oldWidget.delegate._queryTextController.removeListener(_onQueryChanged);
      widget.delegate._queryTextController.addListener(_onQueryChanged);
      oldWidget.delegate._currentBodyNotifier
          .removeListener(_onSearchBodyChanged);
      widget.delegate._currentBodyNotifier.addListener(_onSearchBodyChanged);
      oldWidget.delegate._focusNode = null;
      widget.delegate._focusNode = focusNode;
    }
  }

  void _onFocusChanged() {
    if (focusNode.hasFocus &&
        widget.delegate._currentBody != _OfferSearchBody.suggestions) {
      widget.delegate.showSuggestions(context);
    }
  }

  void _onQueryChanged() {
    setState(() {
      // rebuild ourselves because query changed.
    });
  }

  void _onSearchBodyChanged() {
    setState(() {
      // rebuild ourselves because search body changed.
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = widget.delegate.appBarTheme(context);
    final String searchFieldLabel = widget.delegate.searchFieldLabel ??
        MaterialLocalizations.of(context).searchFieldLabel;
    Widget? body;
    switch (widget.delegate._currentBody) {
      case _OfferSearchBody.suggestions:
        body = KeyedSubtree(
          key: const ValueKey<_OfferSearchBody>(_OfferSearchBody.suggestions),
          child: widget.delegate.buildSuggestions(context),
        );
        break;
      case _OfferSearchBody.results:
        body = KeyedSubtree(
          key: const ValueKey<_OfferSearchBody>(_OfferSearchBody.results),
          child: widget.delegate.buildResults(context),
        );
        break;
      case null:
        break;
    }

    late final String routeName;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        routeName = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        routeName = searchFieldLabel;
    }

    return Semantics(
      explicitChildNodes: true,
      scopesRoute: true,
      namesRoute: true,
      label: routeName,
      child: Theme(
        data: theme,
        child: Scaffold(
            appBar: searchPageAppBar(
              onSubmitted: (String _) {
                widget.delegate.showResults(context);
              },
              controller: widget.delegate._queryTextController,
              onTap: showSearchFilter,
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: body,
            ),
            bottomNavigationBar: bottomNavigationBar(
                onTap: () => Navigator.pop(context),
                text: 'Selected items add')),
      ),
    );
  }

  showSearchFilter() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return widget.delegate.buildFilter(context);
        });
  }
}
