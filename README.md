## Gunslinger Rush

A realtime flutter game with a very simple mechanic: tap faster than your opponent.

[![Watch the video](https://img.youtube.com/vi/sAB275HK6Z8/hqdefault.jpg)](https://www.youtube.com/watch?v=sAB275HK6Z8)

#### Tech under the hood:
- [Supabase Realtime](https://supabase.com/docs/guides/realtime)
- [Riverpod](https://riverpod.dev/)

A few resources to understand the app architecture:
- [Flutter App Architecture with Riverpod](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
- [Flutter Riverpod Generator](https://codewithandrea.com/articles/flutter-riverpod-generator/)

#### Installation?

```sh
git clone [url]
cd [folder]
flutter pub get
flutter run
```

Bonus magic command to build, format and analyze:
```sh
dart run build_runner build --delete-conflicting-outputs && dart format . && flutter analyze
```

#### How to play?
Launch the game, it's realtime pvp so you need another player. Once in the lobby start the game (it automatically matches the user with  the first player waiting). Once in the game, after the Get Ready sign disappears, the ***Shoot*** text will be displayed on the screen, at a random moment. The first player to tap the screen wins the round. Each player has 3 lives, when you lose a round, you lose a live.

#### How to contribute?
If you like the project and want to contribute you can create a PR, fork it and develop separately or whatever works for you. I do want to improve it over time but at the moment (Spring 2024) it is not a priority for me.

