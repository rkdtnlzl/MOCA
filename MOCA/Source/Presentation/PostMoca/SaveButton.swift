//
//  SaveButton.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct SaveButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("작성 완료")
                .font(.pretendardSemiBold18)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(hex: 0xFFAA8F))
        )
        .padding(.horizontal, 10)
    }
}

#Preview {
    SaveButton {
        
    }
}
