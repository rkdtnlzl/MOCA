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
        VStack {
            DatePicker(
                "날짜 선택",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(CompactDatePickerStyle())
            .environment(\.locale, Locale(identifier: "ko_KR"))
            .padding()
            
            Image(uiImage: image)
                .resizable()
            
            Button(action: {
                showImagePicker.toggle()
            }, label: { Text("이미지 선택") })
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showImagePicker, content: {
            ImagePicker(selectedImage: $image)
        })
    }
}



#Preview {
    PostMocaView()
}
