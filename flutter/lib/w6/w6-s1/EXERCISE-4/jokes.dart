class Joke {
  final String title;
  final String description;
  final int id;
  Joke({required this.title, required this.description , required this.id});
}

final List<Joke> jokes = List.generate(
  20,
  (index) => Joke(
    id: index,
    title: 'Joke Title $index',
    description: 'This is the description for Joke $index.',
  ),
);
