//
//  SplashView.swift
//  MOCA
//
//  Created by 강석호 on 9/27/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFAF4F2).ignoresSafeArea()
            
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 40)
                Text("MOCA")
                    .font(.pretendardBold28)
                    .foregroundColor(.black)
                    .padding()
                Text("여러분들의 카공을 기록해보세요")
                    .font(.pretendardMedium16)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    SplashView()
}
