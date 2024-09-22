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
                        .font(.pretendardSemiBold18)
                        .padding(.leading, 20)
                        .padding(.top, 15)
                    
                    Text("\(moca.createAt, formatter: dateFormatter)")
                        .font(.pretendardRegular16)
                        .padding(.top, 2)
                        .padding(.leading, 20)
                    
                    Text("카페 위치")
                        .font(.pretendardSemiBold18)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    Text("\(moca.cafeLocation)")
                        .padding(.top, 2)
                        .padding(.leading, 20)
                    
                    if !moca.todos.isEmpty {
                        Text("카공 내역")
                            .font(.pretendardSemiBold18)
                            .padding(.leading, 20)
                            .padding(.top, 15)
                        
                        List(moca.todos, id: \.id) { todo in
                            Text(todo.title)
                                .padding(.vertical, 5)
                                .padding(.top, 5)
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color(hex: 0xFAF4F2))
                        .listStyle(.plain)
                        .padding(.horizontal, 20)
                        .scrollDisabled(true)
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
