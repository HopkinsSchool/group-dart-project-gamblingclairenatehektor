
import 'dart:io';
import 'dart:math';

// black jack

void main () {

  List cards = <int> [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 15, 15];


  int drawCard() {
    Random rand = Random();
    int choice = rand.nextInt(cards.length);
    int c = cards[choice];
    cards.removeAt(choice);
    return c;
  }

  void checkJoker(int carda, int cardb){
  if(carda == 15 || cardb == 15){
    print("omg!! u got a joker! if your next card is an even number, you win. If not, YOU LOSE......");
    stdout.write("ready to pick, type any key.");
    stdin.readLineSync()!;

    int nextCard = cards[Random().nextInt(cards.length)];

    print("congrats you got a $nextCard");
    if(nextCard%2 == 0){
      gameOver('w');
    }
    else{
      gameOver('l');
    } 
    }
  }

  int card1 = drawCard();
  int card2 = drawCard();

 
  int card3 = drawCard();
  int card4 = drawCard();

  checkJoker(card1, card3);
  checkJoker(card2, card4);

  int playVal = card1 + card3;
  int dealVal = card2 + card4;

  List dealer = <int> [card2, card4];
  List player = <int> [card1, card3];

  if (playVal == 22) {
    playVal = 12;
    card2 = 1;
  }

  print("Your hand is currently $player which is $playVal and the dealer is currently showing a $card4");

  stdout.write("would you like to hit, stand or double down(double)? ");
  var act = stdin.readLineSync()!;

  while ((act == 'double') || (act == 'hit')) {
    int choice = drawCard();
    if (choice == 15) {
      while (choice == 15) {
        choice = drawCard();
      }
    }
    player.add(choice);
    int pick = choice;
    playVal += pick;
    print("you drew a $pick you now have $playVal");
    checkBust(playVal);
    if (act == 'double'){
      dealerTurn(dealer, dealVal, player, playVal, cards);
    }
    stdout.write("would you like to hit or stand? ");
    act = stdin.readLineSync()!;
  }

  dealerTurn(dealer, dealVal, player, playVal, cards);
}

void gameOver (String outCome) {

  switch(outCome) {

    case('w'):
    print("congratulations you win and double your ! 🎉🥳🎉🥳");
    break;
    case('l'):
    print("you suck and you lost all your money your house your car and custody over your children LLLLLLLLLLLLL \n tough luck gg nt but come back we miss you 😞");
    break;
    case('bj'):
    print("you are the luckiest player ever you win 3 to 2 times your bet \nyou should spend all your money to win the billion dollar powerball lottery ✧｡٩(ˊᗜˋ )و✧*｡");
    break;
    case('p'):
    print('you pushed and tied the dealer ¯\_(ツ)_/¯');
    break;
  }

  exit(0);

}


void dealerTurn (List dealHand, int dealVal, List playHand, int playVal, List cards) {

  print("the dealer has $dealHand which is $dealVal");

  if (dealVal < 17) {
    while (dealVal < 17){
      int hit = Random().nextInt(cards.length);
      int choice = cards[hit];
      while (choice == 15) {
          int hit = Random().nextInt(cards.length);
          choice = cards[hit];
      }
      dealHand.add(choice);
      dealVal += choice;
      print("the dealer picked a $choice their hand is now $dealHand they now have $dealVal");
      cards.remove(hit);
    } 
  }

  if (dealVal > 21) {
    print("dealer busted");
    gameOver('w');
  } else if (dealVal == 21) {
    print("dealer has 21");
  }
  if (dealVal > playVal) {
    gameOver('l');
  } else if (dealVal == playVal) {
    gameOver('p');
  } else {
    gameOver('w');
  }
  
}

void checkBust (playVal) {
  if (playVal > 21) {
    print("you busted");
    gameOver('l');
  }
  return;
}


