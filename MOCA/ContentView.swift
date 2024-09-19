//
//  ContentView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        NavigationView {
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
