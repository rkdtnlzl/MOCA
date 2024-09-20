//
//  FindCafeSection.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct FindCafeSection: View {
    @Binding var showCafeName: Bool
    @Binding var cafeName: String
    @Binding var showModal: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("카페 위치 찾기")
                .font(.pretendardSemiBold18)
                .padding(.leading, 10)
                .padding(.top, 25)
            
            Button(action: {
                showModal.toggle()
            }, label: {
                HStack {
                    if showCafeName {
                        Text(cafeName)
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    } else {
                        Spacer()
                    }
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(.trailing, 10)
            })
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .sheet(isPresented: $showModal) {
                FindCafeView(showModal: $showModal, text: $cafeName, showText: $showCafeName)
            }
        }
    }
}
