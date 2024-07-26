//
//  HomeScreenView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import SwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel: HomeViewModel
    @State var isPresented = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    floorPickerView
                    Spacer()
                    datePickerView
                }
                segmentView
                tabView
            }
            progressView
                .hide(if: !viewModel.loadingData)
        }
        .task {
            await viewModel.getAvailableSeats()
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            ConfirmationView(viewModel: viewModel, isLoading: $viewModel.loadingData)
                .presentationDetents([.height(200), .medium,.large])
        }
        .environmentObject(viewModel)
    }
    
    private var datePickerView: some View {
        DatePicker("",selection: $viewModel.selectedDate,
                   in: viewModel.validDateRange, displayedComponents: .date)
        .onChange(of: viewModel.selectedDate) { oldDate, newDate in
            // Ensure selected date is valid; if not, adjust it
            if !viewModel.isValidDate(newDate) {
                viewModel.selectedDate = viewModel.nextValidDate(from: newDate)
            }
        }
        .onAppear {
            // Set the initial selected date to the first valid date
            if !viewModel.isValidDate(viewModel.selectedDate) {
                viewModel.selectedDate = viewModel.nextValidDate(from: Date())
            }
        }
    }
    
    private var floorPickerView: some View {
        Picker("", selection: $viewModel.floor) {
            ForEach(Floors.allCases, id: \.self) { floor in
                Text("\(floor.stingValue)")
                    .foregroundStyle(Color.brandColor)
                    .lexendFont(.light,.h6)
            }
        }
    }
    
    var segmentView: some View {
        Picker("", selection: $viewModel.category) {
            ForEach(Screens.allCases, id: \.self) { category in
                Text("\(category.value)")
                    .foregroundStyle(Color.brandColor)
                    .lexendFont(.light,.h6)
            }
        }
        .pickerStyle(.segmented)
    }
    
    var tabView: some View {
        TabView(selection: $viewModel.category) {
            SeatSelectionView(seats: viewModel.allSeats, isPresented: $isPresented)
                .tag(Screens.desk)
            MeetinRoomsView()
                .tag(Screens.meeting)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.brandColor)
            .scaleEffect(1.2)
    }
}

#Preview {
    HomeScreenView(viewModel: HomeViewModel())
}
