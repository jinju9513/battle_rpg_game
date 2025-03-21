import 'dart:math';

import 'monster_class.dart';
import 'dart:io';

//캐릭터 클래스
class Character {
  String chName = "";
  int chHealth = 0;
  int chPower = 0;
  int chDefense = 0;
  Monster monster = Monster();
  Random random = Random();

  Future<void> loadCharacter() async {
    //캐릭터 데이터 파일 읽어오는 메서드
    var character = File('lib/characters.txt'); //characters파일 읽어오기
    List<String> characterList = await character.readAsLines();
    for (var charValue in characterList) {
      List<String> charValues = charValue.split(',');

      // print('파싱값 : $charValues');
      chHealth = int.parse(charValues[0]);
      chPower = int.parse(charValues[1]);
      chDefense = int.parse(charValues[2]);
    }
  }

  //30% 확률로 체력 증가 기능
   void applyBonusHealth() {
    if (random.nextDouble() < 0.3) { // 0.0 ~ 0.99 사이 난수 발생 (30% 확률)
      chHealth += 10;
      print('🎉 보너스 체력을 얻었습니다! 현재 체력: $chHealth');
    }
  }

  void showStatus() {
    //캐릭터 상태 출력 메서드
    print('$chName- 체력 : $chHealth, 공격력 : $chPower, 방어력 : $chDefense');
  }

  //공격 메서드
  void attackMonster(Monster monster) {
    int damage = max(chPower, 0);//공격력은 최소 0이상
    monster.monHealth -=damage; //몬스터 체력감소
    print('$chName이(가) ${monster.monName}에게 $damage의 데지미를 입혔습니다.');
  }
  //방어 메서드
  void defend() {
    int healAmount = 0; //방어시 회복량
    chHealth +=healAmount;
    print('$chName이(가) 방어태세를 취하여 $healAmount 만큼 체력을 얻었습니다.');
  }
}
