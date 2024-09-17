//
//  PostMocaView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct PostMocaView: View {
    
    @State private var selectedDate = Date()
    @State private var image: UIImage = UIImage()
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(
                "날짜 선택",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(CompactDatePickerStyle())
            .environment(\.locale, Locale(identifier: "ko_KR"))
            
            Text("이미지 선택")
            
            Button(action: {
                showImagePicker.toggle()
            }, label: { Image(systemName: "camera") })
            .buttonStyle(.borderedProminent)
            
            Image(uiImage: image)
                .resizable()
                .frame(width: 100, height: 100)
            
            Button(action: {
                
            }, label: {
                Text("카페 위치 찾기")
            })
            
            Spacer()
            
        }
        .fullScreenCover(isPresented: $showImagePicker, content: {
            ImagePicker(selectedImage: $image)
        })
        .padding()
    }
}

#Preview {
    PostMocaView()
}
