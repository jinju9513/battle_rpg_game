import 'character_class.dart';

//몬스터 클래스
class Monster {
  String monName = "";
  int monHealth = 0;
  int monPower =
      0; //랜덤으로 지정할 공격력 범위 최대값 (int)->몬스터의 공격력은 캐릭터의 방어력보다 작을 수 없습니다. 랜덤으로 지정하여 캐릭터의 방어력과 랜덤 값 중 최대값으로 설정해주세요.
  int monDegfense = 0; //→ 몬스터의 방어력은 0이라고 가정합니다.


  //공격 메서드
  void attackCharacter(Character character) {}
  //상태 출력 메서드
  void showStatus() {}
}
