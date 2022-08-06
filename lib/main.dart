import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluenter/providers/page_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: "Seritrex Fluent App",
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageCount = ref.watch(pageProvider);
    return NavigationView(
      key: const ValueKey(0),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
        selected: pageCount,
        onChanged: (val) {
          ref.read(pageProvider.state).update((state) => val);
        },
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.user_gauge),
            title: const Text("Profile"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.people),
            title: const Text("Students"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.page_permission),
            title: const Text("Courses"),
          ),
        ],
      ),
      content: NavigationBody.builder(
        index: pageCount,
        itemBuilder: (ctx, pageCount) {
          return Text("Page $pageCount");
        },
      ),
    );
  }
}
