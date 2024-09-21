//
//  DateView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI
import RealmSwift

struct DateView: View {
    
    var selectedDate: Date
    var mocaData: [Moca]
    
    @State private var showModal = false
    @State private var selectedMoca: Moca?
    
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
                        
                        if isMocaDate(date: date) {
                            Image("coffeeIcon")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .onTapGesture {
                                    if let moca = getMocaForDate(date: date) {
                                        selectedMoca = moca
                                        showModal = true
                                    }
                                }
                        } else {
                            Spacer()
                                .frame(height: 40)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 80)
                } else {
                    Spacer()
                        .frame(height: 0)
                }
            }
        }
        .sheet(isPresented: $showModal) {
            if let moca = selectedMoca {
                MocaDetailView(moca: moca)
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
    
    func isMocaDate(date: Date) -> Bool {
        let calendar = Calendar.current
        return mocaData.contains { moca in
            calendar.isDate(moca.createAt, 
                            inSameDayAs: date)
        }
    }
    
    func getMocaForDate(date: Date) -> Moca? {
        let calendar = Calendar.current
        return mocaData.first { moca in
            calendar.isDate(moca.createAt, 
                            inSameDayAs: date)
        }
    }
}

#Preview {
    DateView(selectedDate: Date(), mocaData: [])
}
