//
//  MocaDetailView.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct MocaDetailView: View {
    var moca: Moca?
    
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color(hex: 0xFAF4F2).ignoresSafeArea()
            
            if let moca = moca, !isLoading {
                VStack(alignment: .leading) {
                    TabView {
                        ForEach(moca.images, id: \.self) { imageData in
                            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    
                    Text("카공 날짜")
                        .font(.pretendardSemiBold15)
                        .padding(.leading, 20)
                        .padding(.top, 15)
                    
                    Text("\(moca.createAt, formatter: dateFormatter)")
                        .font(.pretendardMedium14)
                        .padding(.top, 1)
                        .padding(.leading, 20)
                    
                    Text("카페 위치")
                        .font(.pretendardSemiBold15)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    Text("\(moca.cafeLocation)")
                        .font(.pretendardMedium14)
                        .padding(.top, 1)
                        .padding(.leading, 20)
                    
                    if !moca.todos.isEmpty {
                        Text("카공 내역")
                            .font(.pretendardSemiBold15)
                            .padding(.leading, 20)
                            .padding(.top, 15)
                        
                        ScrollView {  // 스크롤 가능하게 변경
                            VStack(spacing: 10) {
                                ForEach(moca.todos, id: \.id) { todo in
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
            if moca != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isLoading = false
                }
            }
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
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
