//
//  DateView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct DateView: View {
    
    var selectedDate: Date
    
    var body: some View {
        let days = generateDaysForMonth(for: selectedDate)
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
            ForEach(days, id: \.self) { date in
                if Calendar.current.isDate(date, equalTo: selectedDate, toGranularity: .month) {
                    VStack {
                        Text("\(Calendar.current.component(.day, from: date))")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(height: 20)
                        
                        if isSpecialDate(date: date) {
                            Image("coffeeIcon")
                                .resizable()
                                .frame(width: 40, height: 50)
                        } else {
                            Spacer().frame(height: 50)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 90)
                } else {
                    Spacer() // 빈 칸의 높이를 줄이기 위해 Color.clear 대신 Spacer 사용
                        .frame(height: 0) // 높이를 최소화
                }
            }
        }
    }
    
    func generateDaysForMonth(for date: Date) -> [Date] {
        var days: [Date] = []
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        
        let weekday = calendar.component(.weekday, from: firstOfMonth) - 1
        
        for _ in 0..<weekday {
            days.append(Date.distantPast)
        }
        
        for day in range {
            if let currentDay = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(currentDay)
            }
        }
        
        return days
    }
    
    func isSpecialDate(date: Date) -> Bool {
        let calendar = Calendar.current
        
        // 더미 데이터 추가
        let specialDates = [
            calendar.date(from: DateComponents(year: 2024, month: 9, day: 10))!,
            calendar.date(from: DateComponents(year: 2024, month: 9, day: 8))!
        ]
        
        return specialDates.contains { calendar.isDate(date, inSameDayAs: $0) }
    }
}

#Preview {
    DateView(selectedDate: Date())
}

