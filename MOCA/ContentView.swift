//
//  ContentView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFAF4F2).ignoresSafeArea()
            TabView {
                CalendarView()
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
