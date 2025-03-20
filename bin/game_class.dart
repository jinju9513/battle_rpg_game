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

      if (input != null &&
          input.isNotEmpty &&
          RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(input)) {
        character = input;
        break;
      } else {
        print('⚠ 잘못된 입력입니다. 한글 또는 영문 대소문자만 입력하세요!');
      }
    }
    //캐릭터 정보 로드
    characterObj.chName = character;
    await characterObj.loadCharacter();
    print('\n게임을 시작합니다!');
    characterObj.showStatus();
    await getRandomMonster();

    // battle();
  }

  //전투진행 메서드
  void battle() {
    while (characterObj.chHealth > 0 && monsterObj.monHealth > 0) {
      print('$character의 턴');
      print('\n행동을 선택하세요 (1 : 공격, 2 : 방어)');
      String? action = stdin.readLineSync();
      if (action == '1') {
        characterObj.attackMonster(monsterObj);
      } else if (action == '2') {
        characterObj.defend();
      } else {
        print('\n잘못된 입력입니다. 다시 입력해주세요.');
        continue;
      }
      //몬스터 체력 체크
      if (monsterObj.monHealth <= 0) {
        print('\n${monsterObj.monName}을(를) 물리쳤습니다!');
        break;
      }

      //몬스터 턴
      print('${monsterObj.monName}의 턴');
      monsterObj.attackCharacter(characterObj);

      //캐릭터 체력 체크
      if (characterObj.chHealth <= 0) {
        print('\n${characterObj.chName}이(가) 쓰러졌습니다.... 게임 오버');
        break;
      }
      // 현재 상태 출력
      // print('\n${characterObj.chName} - 체력: ${characterObj.chHealth}, 공격력: ${characterObj.chPower}, 방어력: ${characterObj.chDefense}');
      // print('${monsterObj.monName} - 체력: ${monsterObj.monHealth}, 공격력: ${monsterObj.monPower}');
    }
  }

  //랜덤으로 몬스터 불러오는 메서드
  Future<void> getRandomMonster() async {
    print('\n새로운 몬스터가 나타났습니다!!!');
    await monsterObj.loadMonster(characterObj);
  }
}
