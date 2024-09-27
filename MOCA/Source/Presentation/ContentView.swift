//
//  ContentView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var showMainView = false
    @State private var showPostMocaView = false
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 246/255,
                                                        green: 193/255,
                                                        blue: 141/255,
                                                        alpha: 1)
        
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View {
        ZStack {
            if showMainView {
                NavigationView {
                    TabView(selection: $selectedTab) {
                        CalendarView(showPostMocaView: $showPostMocaView)
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("카공달력")
                            }
                            .tag(0)
                        
                        MapView()
                            .tabItem {
                                Image(systemName: "map")
                                Text("카페지도")
                            }
                            .tag(1)
                        
                        MyPageView(selectedTab: $selectedTab)
                            .tabItem {
                                Image(systemName: "person.crop.circle")
                                Text("마이페이지")
                            }
                            .tag(2)
                    }
                }
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
