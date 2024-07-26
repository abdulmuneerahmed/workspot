//
//  MeetinRoomsView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import SwiftUI

struct MeetinRoomsView: View {
//    @EnvironmentObject private var viewModel: HomeViewModel
    var body: some View {
        ScrollView {
            ForEach((0...10), id: \.self) { i in
                MeetingCardView()
            }
        }
        .padding([.top,.bottom])
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    MeetinRoomsView()
}

