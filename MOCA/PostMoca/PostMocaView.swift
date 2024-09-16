//
//  PostMocaView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct PostMocaView: View {
    
    @State private var selectedDate = Date()
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var isCamera = false
    
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
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
                    .padding()
            }
            
            HStack {
                Button(action: {
                    isCamera = true
                    isImagePickerPresented = true
                }) {
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(.trailing, 10)
                
                Button(action: {
                    isCamera = false
                    isImagePickerPresented = true
                }) {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }
            .padding()
            
            Spacer()
            
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(sourceType: isCamera ? .camera : .photoLibrary, selectedImage: $selectedImage)
        }
    }
}

// ImagePicker 구조체로 UIImagePickerController를 SwiftUI에 맞게 구현
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    PostMocaView()
}
