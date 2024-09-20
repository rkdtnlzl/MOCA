//
//  PostMocaView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI
import RealmSwift

struct PostMocaView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedDate = Date()
    @State private var images: [UIImage] = []
    @State private var showImagePicker: Bool = false
    
    @State private var showCafeName: Bool = false
    @State private var cafeName = ""
    @State private var showModal = false
    
    @State private var todoText = ""
    
    @State private var tempTodos: [Todo] = []
    
    var realm = try! Realm()
    
    var body: some View {
        ZStack {
            Color(hex: 0xFAF4F2).ignoresSafeArea()
            VStack(alignment: .leading) {
                
                DismissButton(dismiss: dismiss)
                
                DateSection(selectedDate: $selectedDate)
                
                ImagePickerSection(images: $images, 
                                   showImagePicker: $showImagePicker)
                
                FindCafeSection(showCafeName: $showCafeName,
                                cafeName: $cafeName,
                                showModal: $showModal)
                
                TodoSection(todoText: $todoText, 
                            tempTodos: $tempTodos,
                            addItem: addItem,
                            deleteItem: deleteItem)
                
                Spacer()
                
                SaveButton {
                    saveMocaToRealm()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .fullScreenCover(isPresented: $showImagePicker, content: {
                ImagePicker(selectedImages: $images)
            })
            .padding()
        }
    }
    
    func addItem() {
        guard !todoText.isEmpty else { return }
        
        let newTodo = Todo(title: todoText, 
                           complete: false)
        
        tempTodos.append(newTodo)
        todoText = ""
    }
    
    func deleteItem(_ item: Todo) {
        tempTodos.removeAll { $0.id == item.id }
    }
    
    func saveMocaToRealm() {
        let imageDataList = images.compactMap { $0.pngData() }
        
        let newMoca = Moca(createAt: selectedDate, images: imageDataList, cafeLocation: cafeName, todos: tempTodos)
        
        try! realm.write {
            realm.add(newMoca)
        }
        
        dismiss()
    }
}


#Preview {
    PostMocaView()
}
