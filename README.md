## ☕️ MOCA - 카공족들을 위한 카페 공부 기록 앱
**카공한 기록**을 남기고 싶은 사람들을 위한, <br>
내 **주변 카페 위치**를 알고 싶은 사람 위한 서비스 입니다

## 🙂 About
<img src="https://github.com/user-attachments/assets/aaaef69c-5a8a-4732-a2f3-df2fea8a9db0" alt="moca_preview1" width="270" height="550">
<img src="https://github.com/user-attachments/assets/ceca10e2-6344-4d9d-98a6-814b2e1abc30" alt="moca_preview2" width="270" height="550">
<img src="https://github.com/user-attachments/assets/d45f1a42-f645-43e3-805a-ba79b58eb01e" alt="moca_preview3" width="270" height="550">
<br>
<br>

## 🛠️ 기술 스택
- **SwiftUI**: 유저 인터페이스를 선언형 방식으로 구현, 더 적은 코드로 복잡한 UI를 효율적으로 구성
- **Realm**: 빠르고 경량화된 로컬 데이터베이스로, 카페 기록과 공부 기록을 로컬에 저장하고 관리
- **MapKit**: 사용자의 위치를 기반으로 주변 카페를 표시하고, 카페 위치를 지도로 제공
- **Combine**: 비동기 데이터 스트림을 처리하고, 데이터 변화에 따른 UI 업데이트를 효율적으로 관리
- **Kakao Local API**: 사용자의 현재 위치를 기준으로 주변 카페 정보를 가져오는 데 활용
- **CoreLocation**: 사용자의 위치 정보를 정확하게 받아오고, 지도에 반영
<br>

## 🚀 앱스토어
[MOCA](https://apps.apple.com/app/moca-%EC%B9%B4%EA%B3%B5%EC%A1%B1%EB%93%A4%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%B9%B4%ED%8E%98-%EA%B3%B5%EB%B6%80-%EA%B8%B0%EB%A1%9D-%EC%95%B1/id6723889266)
<br>


## 💁 프로젝트 정보
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

## 🤔 고민했던 점
### MapKit 구현 시 iOS 버전 차이에 따른 개발 전략
- **고민한 점**
```
if #available(iOS 17.0, *) {
  Map {
       ...             
  }
} else {
    // Fallback on earlier versions
}
```
SwiftUI로 MapKit을 구현할 때 iOS 17 이상과 이전 버전에서 각각 다른 방식으로 지도를 구현해야 함. 분기 처리를 통해 iOS 17 이상과 이하 버전을 나눠서 구현할 수 있지만, 이렇게 되면 두 가지 구현 방식을 모두 유지해야 하므로 코드가 중복되고 복잡해질 수 있음. 또한, SwiftUI와 UIKit의 상호작용이나 데이터 상태 관리를 일관되게 처리하는 데 어려움이 있음. 구체적인 예로, iOS 17에서는 상태 바인딩을 통해 간단히 구현할 수 있는 기능을 iOS 16 이하에서는 델리게이트 메서드를 작성하고, 관련 프로토콜을 채택해야 하는 차이점이 발생함.

- **결론**
```
struct MapView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
}
```
따라서 iOS 17 이상에서도 SwiftUI의 Map 뷰를 사용하지 않고, 일관되게 UIViewControllerRepresentable을 사용해 UIKit의 MKMapView를 SwiftUI에 통합하는 방법을 선택함.

<br>

## 😥 트러블 슈팅
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
