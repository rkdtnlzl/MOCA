//
//  CalendarView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(selectedDate: $selectedDate)
                
                HStack {
                    ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { symbol in
                        Text(symbol)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 30)
                
                DateView(selectedDate: selectedDate)
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: PostMocaView()) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: 0xFFAA8F))
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CalendarView()
}
