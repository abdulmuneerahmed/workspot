//
//  SeatSelectionView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 21/07/24.
//

import SwiftUI

struct SeatSelectionView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @StateObject private var seatViewModel = SeatViewModel()
    @Binding var isPresented: Bool
    
    var totalSeats: [SeatDetails]
    
    init(seats: [SeatDetails], isPresented: Binding<Bool>) {
        totalSeats = seats
        self._isPresented = isPresented
    }
    
    private var gridItemLayout = [
        GridItem(.flexible(minimum: 50),spacing: 12),
        GridItem(.flexible(minimum: 50), spacing: 50),
        GridItem(.flexible(minimum: 50),spacing: 12),
        GridItem(.flexible(minimum: 50),spacing: 12)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            headingView
            ZStack {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout) {
                        ForEach(seatViewModel.seats) { seat in
                            Button {
                                isPresented = true
                                viewModel.selectedSeat = seat.seatNumber
                            } label: {
                                Text(String(seat.seatNumber))
                                    .lexendFont()
                                    .foregroundStyle(seat.isSelected ? .white : seatAvailable(seat.seatNumber))
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                                    .background {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(seat.isSelected ? Color.brandColor : Color.white)
                                            .stroke(seatAvailable(seat.seatNumber))
                                    }
                            }
                            .disabled(!viewModel.isSeatAvailable(seat.seatNumber))
                        }
                    }
                    .padding()
                }
            }
            .border(Color.placeholderColor.opacity(0.2), width: 1)
        }
    }
    
    private func seatAvailable(_ seat: Int) -> Color {
        let check = viewModel.isSeatAvailable(seat)
        return check ? Color.brandColor.opacity(0.75) : Color.placeholderColor.opacity(0.2)
    }
    
    private var headingView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Select a Seat")
                .lexendFont(.medium, .h0)
                .foregroundColor(Color.blacktextColor)
            HStack(spacing: 15) {
                statusInfoView("Reserved", Color.placeholderColor.opacity(0.2))
                statusInfoView("Available", Color.brandColor.opacity(0.75))
            }
        }
    }
    
    private func statusInfoView(_ title: String, _ color: Color) -> some View {
        HStack(alignment: .center) {
            Circle().foregroundColor(color)
                .frame(height: 10)
            Text(title)
                .foregroundStyle(Color.blacktextColor)
                .lexendFont(.light, .h5)
        }
    }
}

//#Preview {
//    SeatSelectionView(totalSeats: .constant([]))
//        .padding()
//}
