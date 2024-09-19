//
//  PostMocaView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI
import RealmSwift

struct PostMocaView: View {
    
    @State private var selectedDate = Date()
    @State private var images: [UIImage] = []
    @State private var showImagePicker: Bool = false
    
    @State private var showCafeName: Bool = false
    @State private var cafeName: String = ""
    @State private var showModal: Bool = false
    
    @State private var todoText = ""
    
    @ObservedResults(Todo.self)
    var todo
    
    var body: some View {
        ZStack {
            Color(hex: 0xFAF4F2).ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Text("날짜 선택")
                    .font(.pretendardSemiBold18)
                    .padding(.leading, 10)
                
                DatePicker(selection: $selectedDate, displayedComponents: .date) { }
                    .datePickerStyle(CompactDatePickerStyle())
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .labelsHidden()
                
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
                
                Text("할 일")
                    .font(.pretendardSemiBold18)
                    .padding(.leading, 10)
                    .padding(.top, 25)
                
                List {
                    TextField("할 일 입력", text: $todoText)
                        .onSubmit {
                            addItem()
                        }
                    ForEach(todo, id: \.id) { item in
                        ExtractedView(todo: item)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    $todo.remove(item)
                                } label: {
                                    Text("삭제")
                                }
                            }
                    }
                }
                .listStyle(PlainListStyle())
                
                Spacer()
                
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
        
        let data = Todo(title: todoText, complete: false)
        
        $todo.append(data)
        
        todoText = ""
    }
}

struct ExtractedView: View {
    
    @ObservedRealmObject
    var todo: Todo
    
    var body: some View {
        HStack {
            Button(action: {
                $todo.complete.wrappedValue.toggle()
            }, label: {
                let name = todo.complete ? "checkmark.square.fill" : "checkmark.square"
                Image(systemName: name)
            })
            Text(todo.title)
        }
    }
}

#Preview {
    PostMocaView()
}
