//
//  DateSection.swift
//  MOCA
//
//  Created by 강석호 on 9/20/24.
//

import SwiftUI

struct DateSection: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("날짜 선택")
                .font(.pretendardSemiBold18)
                .padding(.leading, 10)
            
            DatePicker(selection: $selectedDate, displayedComponents: .date) { }
                .datePickerStyle(CompactDatePickerStyle())
                .environment(\.locale, Locale(identifier: "ko_KR"))
                .labelsHidden()
        }
    }
}

#Preview {
    DateSection(selectedDate: .constant(.now))
}
