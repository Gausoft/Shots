import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shots/app/models/pack_model.dart';
import 'package:shots/app/models/shot_card_model.dart';
import 'package:shots/app/providers/packs_provider.dart';
import 'package:shots/app/services/card_loading.dart';
import 'package:yaml/yaml.dart';

class CardProvider extends ChangeNotifier {
  List<ShotCardModel> _cards = [];
  List<ShotCardModel> get cards => _cards;

  int _currentCardIndex = 0;
  int get currentCardIndex => _currentCardIndex;

  // number of cards to show behind current card
  int _nextCardsNo = 5;
  int get nextCardsNo => _nextCardsNo;

  // game started is to determine whether to re-load the cards
  bool _gameStarted = false;
  bool get gameStarted => _gameStarted;

  // called on game start
  loadCards(BuildContext context) async {
    // load each pack and cards in respective packs
    final PacksProvider packsProvider = Provider.of<PacksProvider>(context, listen: false);
    _cards = await CardLoadingService.loadPacks(packsProvider.packs);

    // randomize order
    shuffleCards();

    _gameStarted = true;
  }

  shuffleCards({bool shouldNotifyListeners = false}) {
    _cards.shuffle();

    // only need to notify listeners when user re-shuffles
    if (shouldNotifyListeners) notifyListeners();
  }

  // called when a card is dragged away
  nextCard() {
    // go to next card
    _currentCardIndex += 1;

    /*
    If we're 5 less than the total number of cards currently, add new ones

    */
    if (_currentCardIndex == _cards.length - _nextCardsNo) {
      // TODO: implement load next set of cards
      // loadCards();
    }

    notifyListeners();
  }

  endGame() {
    // clear cards (empty array)
    _currentCardIndex = 0;
    _cards = [];
    _gameStarted = false;
  }
}
