import 'monster_class.dart';
import 'dart:io';

//캐릭터 클래스
class Character {
  String chName = "";
  int chHealth = 0;
  int chPower = 0;
  int chDefense = 0;

  Future<void> loadCharacter() async {
    //캐릭터 데이터 파일 읽어오는 메서드
    var character = File('lib/characters.txt'); //characters파일 읽어오기
    List<String> characterList = await character.readAsLines();
    for (var charValue in characterList) {
      List<String> charValues = charValue.split(',');

      print('파싱값 : $charValues');
      chHealth = int.parse(charValues[0]);
      chPower = int.parse(charValues[1]);
      chDefense = int.parse(charValues[2]);
    }
  }

  void showStatus() {
    //캐릭터 상태 출력 메서드
    print('$chName- 체력 : $chHealth, 공격력 : $chPower, 방어력 : $chDefense');
  }

  //공격 메서드
  void attackMonster(Monster monster) {}
  //방어 메서드
  void defend() {}
}
