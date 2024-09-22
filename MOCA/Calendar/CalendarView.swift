//
//  CalendarView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI
import RealmSwift

struct CalendarView: View {
    
    @State private var selectedDate = Date()
    @StateObject private var realmManager = MocaRealmManager()
    
    @Binding var showPostMocaView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0xFAF4F2).ignoresSafeArea()
                VStack(spacing: 0) {
                    HeaderView(selectedDate: $selectedDate)
                    
                    HStack {
                        ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { symbol in
                            Text(symbol)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: 30)
                    
                    DateView(selectedDate: selectedDate,
                             mocaData: realmManager.mocaData)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            showPostMocaView.toggle()
                        }) {
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
        .fullScreenCover(isPresented: $showPostMocaView, onDismiss: {
            realmManager.loadMocaData()
        }) {
            PostMocaView()
        }
        .onAppear {
            realmManager.loadMocaData()
            print(Realm.Configuration.defaultConfiguration.fileURL)
        }
    }
}

#Preview {
    CalendarView(showPostMocaView: .constant(false))
}
