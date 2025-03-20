import 'dart:io';
import 'dart:math';
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
   

    // 유효한 캐릭터 이름 입력받기
    while (true) {
      print('캐릭터 이름을 입력하세요 🦹 (한글/영문만 가능):');
      String? input = stdin.readLineSync();

      if (input != null && input.isNotEmpty && RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(input)) {
        character = input;
        break;
      } else {
        print('⚠ 잘못된 입력입니다. 한글 또는 영문 대소문자만 입력하세요!');
      }
    }
    //캐릭터 정보 로드
    characterObj.chName = character;
    await characterObj.loadCharacter();
    print('게임을 시작합니다!');
    characterObj.showStatus();
    getRandomMonster();
  }

  //전투진행 메서드
  void battle() {}
  //랜덤으로 몬스터 불러오는 메서드
  void getRandomMonster() async {
    print('새로운 몬스터가 나타났습니다!!!');
    await monsterObj.loadMonster(characterObj);
  }
}
