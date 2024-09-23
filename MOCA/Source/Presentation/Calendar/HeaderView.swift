//
//  HeaderView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack {
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
            }) {
                Image(systemName: "chevron.left")
                    .padding()
                    .foregroundColor(.black)
            }
            
            Text(selectedDate, formatter: Self.dateFormatter)
                .font(.title2)
                .fontWeight(.semibold)
            
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
            }) {
                Image(systemName: "chevron.right")
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }()
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State var previewDate = Date()
    
    var body: some View {
        HeaderView(selectedDate: $previewDate)
    }
}
