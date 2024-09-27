//
//  MyPageView.swift
//  MOCA
//
//  Created by 강석호 on 9/19/24.
//

import SwiftUI
import RealmSwift

struct MyPageView: View {
    @Binding var selectedTab: Int
    @State private var showAlert = false
    @ObservedObject var realmManager = MocaRealmManager()
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("버전")
                        .font(.pretendardMedium16)
                    Spacer()
                    Text("1.0.0")
                        .font(.pretendardMedium16)
                        .foregroundColor(.gray)
                }
                HStack {
                    Button(action: {
                        sendEmail()
                    }) {
                        HStack {
                            Text("문의하기")
                                .font(.pretendardMedium16)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            Section {
                HStack {
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("데이터 초기화")
                            .font(.pretendardMedium16)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("모든 카공 기록을 삭제하시겠습니까?"),
                message: Text("이 작업은 되돌릴 수 없습니다."),
                primaryButton: .destructive(Text("삭제")) {
                    deleteAllData()
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
    
    func sendEmail() {
        let email = "rkdtnlzl@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func deleteAllData() {
        realmManager.deleteAllMocaData()
        selectedTab = 0
    }
}

#Preview {
    MyPageView(selectedTab: .constant(2))
}
