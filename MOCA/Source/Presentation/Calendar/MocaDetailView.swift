//
//  MocaDetailView.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI
import RealmSwift

struct MocaDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoading = true
    @State private var images: [Data?] = []
    @State private var todos: [Todo] = []
    @State private var createAt: Date = Date()
    @State private var cafeLocation: String = ""
    
    var moca: Moca

    @StateObject private var realmManager = MocaRealmManager()

    var body: some View {
        ZStack {
            Color(hex: 0xFAF4F2).ignoresSafeArea()

            if !isLoading {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            deleteMoca()
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    if !images.isEmpty {
                        TabView {
                            ForEach(images, id: \.self) { imageData in
                                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                    }

                    Text("카공 날짜")
                        .font(.pretendardSemiBold15)
                        .padding(.leading, 20)
                        .padding(.top, 15)

                    Text("\(createAt, formatter: dateFormatter)")
                        .font(.pretendardMedium14)
                        .padding(.top, 1)
                        .padding(.leading, 20)

                    Text("카페 위치")
                        .font(.pretendardSemiBold15)
                        .padding(.leading, 20)
                        .padding(.top, 20)

                    Text("\(cafeLocation)")
                        .font(.pretendardMedium14)
                        .padding(.top, 1)
                        .padding(.leading, 20)

                    if !todos.isEmpty {
                        Text("카공 내역")
                            .font(.pretendardSemiBold15)
                            .padding(.leading, 20)
                            .padding(.top, 15)
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(todos, id: \.id) { todo in
                                    HStack {
                                        Text(todo.title)
                                            .font(.pretendardMedium14)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(height: 50)
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                                    )
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.top, 10)
                        }
                        .frame(maxHeight: .infinity)
                    }
                    Spacer()
                }
            } else {
                VStack {
                    ProgressView("데이터를 불러오는 중...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1)
                }
            }
        }
        .onAppear {
            images = Array(moca.images)
            todos = Array(moca.todos)
            createAt = moca.createAt
            cafeLocation = moca.cafeLocation

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isLoading = false
            }
        }
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }

    func deleteMoca() {
        presentationMode.wrappedValue.dismiss()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(moca)
            }

            NotificationCenter.default.post(name: NSNotification.Name("MocaDataUpdated"), object: nil)
        }
    }
}


#Preview {
    let sampleTodos = [
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "iOS 공부", complete: false),
        Todo(title: "SwiftUI 프로젝트 작업", complete: true)
    ]
    
    let starImage1 = UIImage(systemName: "star")?.pngData() ?? Data()
    let starImage2 = UIImage(systemName: "star.fill")?.pngData() ?? Data()
    
    let sampleMoca = Moca(
        createAt: Date(),
        images: [starImage1, starImage2],
        cafeLocation: "스타벅스 강남점",
        todos: sampleTodos
    )
    
    return MocaDetailView(moca: sampleMoca)
}
