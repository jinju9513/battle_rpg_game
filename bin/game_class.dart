import 'dart:io';
import 'monster_class.dart';
import 'character_class.dart';

//게임 클래스
class Game {
  String character = ""; // 캐릭터
  List<Monster> monsterList = []; //몬스터 리스트
  int dftdCnt = 0; // 물리친 몬스터 개수
  Character characterObj = Character(); //character_class
  Monster monsterObj = Monster(); //monster_class
  //게임 시작 메서드
  void startGame() async {
    print('캐릭터 이름을 입력하세요 🦹 :');
    String? name = stdin.readLineSync(); // 캐릭터 이름 입력받기
    character = name.toString();

    //캐릭터 정보 로드
    characterObj.chName = character;
    await characterObj.loadCharacter();
    print('게임을 시작합니다!');
    characterObj.showStatus();

    print('새로운 몬스터가 나타났습니다!!');
    await monsterObj.loadMonster(characterObj);
  }

  //전투진행 메서드
  void battle() {}
  //랜덤으로 몬스터 불러오는 메서드
  void getRandomMonster() {}
}
