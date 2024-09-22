//
//  ContentView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showPostMocaView = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 246/255,
                                                        green: 193/255,
                                                        blue: 141/255,
                                                        alpha: 1)

        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View {
        NavigationView {
            TabView {
                CalendarView(showPostMocaView: $showPostMocaView)
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                    }
                MyPageView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
