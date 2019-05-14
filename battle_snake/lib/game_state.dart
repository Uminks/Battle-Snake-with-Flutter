part of game;

class GameState {

  int _lastScore = 0;
  int _reachedLevel = 0;
  List<dynamic> _BestScores = new List<int>();

  int get lastScore => _lastScore;
  List<dynamic> get BestScores => _BestScores;
  set lastScore(int lastScore) {
    _lastScore = lastScore;
  }

  Future load() async {
    String dataDir = (await getApplicationDocumentsDirectory()).path;
    File file = new File(dataDir + '/gamestate.json');
    if (file.existsSync()) {
      String json = file.readAsStringSync();
      JsonDecoder decoder = new JsonDecoder();
      Map data = decoder.convert(json);

      _BestScores = data['score'];
      _reachedLevel = data['reachedLevel'];
    }
  }

  Future store() async {
    _BestScores.add(_lastScore);
    List<dynamic> _scores = new List<int>();
    _scores = _BestScores;
    _scores.sort((b, a) => a.compareTo(b));

    _BestScores = new List<int>();
    int cont = 0;
    for(int value in _scores){
      if(cont++ < 5)
        _BestScores.add(value);
    }

    String dataDir = (await getApplicationDocumentsDirectory()).path;
    File file = new File(dataDir + '/gamestate.json');
    Map data = {
      'score': _BestScores,
      'reachedLevel': _reachedLevel
    };
    JsonEncoder encoder = new JsonEncoder();
    String json = encoder.convert(data);
    file.writeAsStringSync(json);
  }

  void reachedLevel(int level) {
    _reachedLevel = level;
    store();
  }

}