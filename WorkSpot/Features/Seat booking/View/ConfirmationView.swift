//
//  ConfirmationView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 26/07/24.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Confirm to make a Reservation?")
                    .lexendFont(.black,.h2)
                Text("Date: \(viewModel.selectedDate.ymdFormat) | Floor: \(viewModel.floor.stingValue) | Desk: \(viewModel.selectedSeat)")
                    .lexendFont(.light, .h4)
            }
            .padding([.top,.bottom])
            actionsViews
        }
        .padding()
    }
    
    var actionsViews: some View {
        HStack(alignment: .center) {
            Spacer()
            Button {
                dismiss()
            } label: {
                cancelContentView
                    .padding()
                    .foregroundStyle(.white)
                    .lexendFont(.light)
                    .background(Color.placeholderColor)
                    .frame(minWidth: 120)
            }
            Button {
                
            } label: {
                continueButtonView
                    .frame(minWidth: 120)
            }

            Spacer()
        }
    }
    
    var continueButtonView: some View {
        Button {
            Task {
                await viewModel.confirmReservation(.booked)
                dismiss()
            }
        } label: {
            continueContentView
                .padding()
                .foregroundStyle(.white)
                .lexendFont(.light)
                .background(Color.brandColor)
                .frame(minWidth: 120)
        }
        .disabled(isLoading)
    }
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.white)
            .scaleEffect(1.2)
    }
    
    var continueContentView: some View {
        HStack {
            Spacer()
            if isLoading {
                progressView
            } else {
                Text("Confirm")
            }
            Spacer()
        }
    }
    
    var cancelContentView: some View {
        HStack {
            Spacer()
            Text("Cancel")
            Spacer()
        }
    }
}

//#Preview {
//    ConfirmationView(isLoading: .constant(true))
//}
