//
//  ImagePickerSection.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct ImagePickerSection: View {
    @Binding var images: [UIImage]
    @Binding var showImagePicker: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이미지 선택")
                .font(.pretendardSemiBold18)
                .padding(.leading, 10)
                .padding(.top, 25)
            
            HStack {
                ForEach(0..<min(images.count, 3), id: \.self) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                }
                
                if images.count < 3 {
                    Button(action: {
                        showImagePicker.toggle()
                    }, label: {
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    })
                    .frame(width: 80, height: 80)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .padding(.leading, 10)
        }
    }
}
