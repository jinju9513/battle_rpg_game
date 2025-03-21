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

    // 몬스터와 계속 싸우는 루프 추가
    while (characterObj.chHealth > 0) {
      await getRandomMonster(); // 새 몬스터 등장
      battle(); // 전투 진행

      dftdCnt++; //물리친 몬스터 수 증가

      // 모든 몬스터 처치 후 계속 싸울지 물어보기
      if (characterObj.chHealth > 0) {
        print("\n다음 몬스터와 싸우시겠습니까? (y/n): ");
        String? answer = stdin.readLineSync();
        if (answer == null || answer.toLowerCase() != 'y') {
          print("게임을 종료합니다.");
          break;
        }
      }
    }
    // 게임 종료 메시지 출력
    String gameResult = characterObj.chHealth > 0 ? "승리" : "패배";
    if (characterObj.chHealth > 0) {
      print("🎉 모든 몬스터를 물리쳤습니다! 축하합니다! 🎉");
    } else {
      print("😵 ${characterObj.chName}이(가) 쓰러졌습니다... 게임 오버!");
    }

    // 결과 저장 여부 확인
    print("\n결과를 저장하시겠습니까? (y/n): ");
    String? saveAnswer = stdin.readLineSync();
    if (saveAnswer != null && saveAnswer.toLowerCase() == 'y') {
      saveGameResult(characterObj.chName, characterObj.chHealth, gameResult);
    }

    print("게임을 종료합니다.");
  }

  //전투진행 메서드
  void battle() {
    while (characterObj.chHealth > 0 && monsterObj.monHealth > 0) {
      print('\n$character의 턴');
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
      print('\n${monsterObj.monName}의 턴');
      monsterObj.attackCharacter(characterObj);

      //캐릭터 체력 체크
      if (characterObj.chHealth <= 0) {
        print('\n${characterObj.chName}이(가) 쓰러졌습니다.... 게임 오버');
        break;
      }

      characterObj.showStatus();
      monsterObj.showStatus();
    }
  }

  // 결과 저장 메서드
  void saveGameResult(
    String characterName,
    int remainingHealth,
    String result,
  ) {
    File file = File('lib/result.txt'); // 저장할 파일
    String resultText = "캐릭터: $characterName\n";
    resultText += "남은 체력: $remainingHealth\n";
    resultText += "게임 결과: $result\n";

    file.writeAsStringSync(resultText);
    print("\n✅ 게임 결과가 'result.txt' 파일에 저장되었습니다!");
  }

  //랜덤으로 몬스터 불러오는 메서드
  Future<void> getRandomMonster() async {
    print('\n새로운 몬스터가 나타났습니다!!!');
    await monsterObj.loadMonster(characterObj);
    monsterObj.showStatus();
  }
}
