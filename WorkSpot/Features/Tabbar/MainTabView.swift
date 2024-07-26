//
//  MainTabView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 20/07/24.
//

import SwiftUI

struct MainTabView: View {
    
    private enum Tabs: Int {
        case home
        case scanner
        case profile
    }
    var body: some View {
        TabView {
            HomeScreenView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                        .renderingMode(.template)
                    Text("Home")
                }
                .tag(0)
            ScannerView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                        .renderingMode(.template)
                    Text("Scanner")
                }
                .tag(0)
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                        .renderingMode(.template)
                    Text("History")
                }
                .tag(1)
        }
        .toolbarBackground(Color.placeholderColor, for: .tabBar)
    }
}

#Preview {
    MainTabView()
}
