//
//  DismissButton.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct DismissButton: View {
    var dismiss: DismissAction
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .padding(.trailing, 10)
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 30, height: 30)
            }
        }
        .padding(.bottom)
    }
}
