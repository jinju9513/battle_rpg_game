import 'dart:math';
import 'character_class.dart';
import 'dart:io';

//몬스터 클래스
class Monster {
  String monName = "";
  int monHealth = 0;
  int monPower =
      0; //랜덤으로 지정할 공격력 범위 최대값 (int)->몬스터의 공격력은 캐릭터의 방어력보다 작을 수 없습니다. 랜덤으로 지정하여 캐릭터의 방어력과 랜덤 값 중 최대값으로 설정해주세요.
  int monDegfense = 0; //→ 몬스터의 방어력은 0이라고 가정합니다.
  var random = Random();
  Character characterObj = Character();

  Future<void> loadMonster(Character characterObj) async {
    //캐릭터 데이터 파일 읽어오는 메서드
    var monster = File('lib/monsters.txt'); //monsters 파일 읽어오기
    List<String> monsterList = await monster.readAsLines();
    int randomIndex = random.nextInt(
      monsterList.length,
    ); // 리스트의 길이 만큼 랜덤 인덱스 생성
    List<String> monValues = monsterList[randomIndex].split(
      ',',
    ); //선택된 몬스터 데이터 파싱

    // print('$monsterList');
    monName = monValues[0];
    monHealth = int.parse(monValues[1]);
    int maxPower = int.parse(monValues[2]); // 몬스터 공격력 최대값
    monPower = random.nextInt(maxPower + 1); // 0~maxPower까지 랜덤 값 생성
    monPower = max(monPower, characterObj.chDefense);
    print(characterObj.chDefense);
    print('$monName - 체력 : $monHealth, 공격력 : $monPower');
  }

  //공격 메서드
  void attackCharacter(Character character) {}
  //상태 출력 메서드
  void showStatus() {}
}
