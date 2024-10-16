## ☕️ MOCA - 카공족들을 위한 카페 공부 기록 앱
**카공한 기록**을 남기고 싶은 사람들을 위한, <br>
내 **주변 카페 위치**를 알고 싶은 사람 위한 서비스 입니다

## 🤔 About
<img src="https://github.com/user-attachments/assets/aaaef69c-5a8a-4732-a2f3-df2fea8a9db0" alt="moca_preview1" width="270" height="550">
<img src="https://github.com/user-attachments/assets/ceca10e2-6344-4d9d-98a6-814b2e1abc30" alt="moca_preview2" width="270" height="550">
<img src="https://github.com/user-attachments/assets/d45f1a42-f645-43e3-805a-ba79b58eb01e" alt="moca_preview3" width="270" height="550">
<br>
<br>

## 🛠️ Tech
- **SwiftUI**: 유저 인터페이스를 선언형 방식으로 구현, 더 적은 코드로 복잡한 UI를 효율적으로 구성
- **Realm**: 빠르고 경량화된 로컬 데이터베이스로, 카페 기록과 공부 기록을 로컬에 저장하고 관리
- **MapKit**: 사용자의 위치를 기반으로 주변 카페를 표시하고, 카페 위치를 지도로 제공
- **Combine**: 비동기 데이터 스트림을 처리하고, 데이터 변화에 따른 UI 업데이트를 효율적으로 관리
- **Kakao Local API**: 사용자의 현재 위치를 기준으로 주변 카페 정보를 가져오는 데 활용
- **CoreLocation**: 사용자의 위치 정보를 정확하게 받아오고, 지도에 반영
<br>

## 🚀 AppStore
[MOCA](https://apps.apple.com/app/moca-%EC%B9%B4%EA%B3%B5%EC%A1%B1%EB%93%A4%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%B9%B4%ED%8E%98-%EA%B3%B5%EB%B6%80-%EA%B8%B0%EB%A1%9D-%EC%95%B1/id6723889266)
<br>


## Project Info
- 기간 : 2024.09.16 ~ 2024.09.27
- 개발 인원 : 1명
- 지원 버전: iOS 16.0 +

- **주요 기능**

  - `카공 달력`
    - 날짜별 카공 내역 조회
    - 커스텀 달력을 통해 직관적인 UI/UX 제공
   
  - `카공 기록`
    - 이미지 저장 기능
    - 카페 위치 조회 및 저장 기능
    - List별 카공 내역 저장 기능
   
  - `주변 카페 조회`
    - 사용자 위치 기반 카페 조회 기능
    - 카메라 시점에 따른 카페 조회 기능

<br>

## Trouble Shooting
### Realm 데이터 갱신 이슈
**문제 상황**<br>
MocaDetailView에서 사용자가 삭제 작업을 진행할 때 Realm 데이터가 제대로 반영되지 않는 문제가 발생했음.<br>
이 문제로 인해 사용자가 데이터를 삭제했음에도 뷰에 계속 남아 있거나 앱이 예기치 않게 동작하는 상황이 있었음.<br>

**문제 원인**
- **Realm 데이터 처리 타이밍 문제**: Realm에서 데이터를 삭제한 후, 삭제된 데이터를 즉시 반영해야 하지만 뷰를 닫고 나서 Realm 삭제 작업을 처리하고 있음.<br>
- **UI 갱신 문제**: Realm 데이터가 삭제되었음에도 UI 갱신이 즉시 이루어지지 않아, 사용자가 삭제한 데이터를 여전히 볼 수 있는 문제 발생했을 수 있음.<br>


**해결 방안**
- **데이터 삭제 후 알림을 사용하여 UI 갱신**: 데이터를 삭제한 후, NotificationCenter를 통해 MocaDataUpdated 알림을 보내도록 함. <br>
  이 알림을 수신하는 다른 뷰에서는 해당 알림이 발생하면 데이터를 다시 로드하도록 처리함으로써 데이터 변경 사항을 즉시 반영하게 했음.<br><br>
- **UI와 데이터 처리 순서 조정**: deleteMoca() 함수에서 데이터를 삭제하고 UI가 업데이트되기 전에 `presentationMode.wrappedValue.dismiss()`를 호출했음.
  이 순서를 조정하여, Realm 데이터가 먼저 삭제된 후 UI가 닫히도록 변경했음. 이를 통해 타이밍 문제를 해결하고 데이터가 정상적으로 반영되도록 처리했음.<br><br>

```
func deleteMoca() {
        presentationMode.wrappedValue.dismiss()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(moca)
            }

            NotificationCenter.default.post(name: NSNotification.Name("MocaDataUpdated"), object: nil)
        }
}
```
