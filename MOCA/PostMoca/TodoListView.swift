//
//  TodoListView.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct TodoListView: View {
    
    let todo: Todo
    
    var body: some View {
        HStack {
            Text(todo.title)
                .font(.pretendardSemiBold17)
        }
    }
}

#Preview {
    TodoListView(todo: Todo(title: "할일1", complete: true))
}
