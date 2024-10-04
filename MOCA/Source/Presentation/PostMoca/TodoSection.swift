//
//  TodoSection.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct TodoSection: View {
    @Binding var todoText: String
    @Binding var tempTodos: [Todo]
    
    var addItem: () -> Void
    var deleteItem: (Todo) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("카페 공부 내역")
                .font(.pretendardSemiBold18)
                .padding(.leading, 10)
                .padding(.top, 25)
            
            TextField("공부 내용 입력", text: $todoText)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .submitLabel(.done)
                .onSubmit {
                    addItem()
                }
            
            List {
                ForEach(tempTodos, id: \.id) { item in
                    TodoListView(todo: item)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteItem(item)
                            } label: {
                                Text("삭제")
                            }
                        }
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 10)
        }
    }
}
