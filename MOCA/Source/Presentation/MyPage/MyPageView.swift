//
//  MyPageView.swift
//  MOCA
//
//  Created by 강석호 on 9/19/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        List {
            
            Section {
                Text("이용약관")
                    .font(.pretendardMedium16)
                Text("문의하기")
                    .font(.pretendardMedium16)
            }
            
            Section {
                HStack {
                    Text("데이터 초기화")
                        .font(.pretendardMedium16)
                        .foregroundColor(.red)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    MyPageView()
}
