//
//  MeetingCardView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import SwiftUI

struct MeetingCardView: View {
    @State var isLoading = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Meeting Room 10")
                        .lexendFont(.semiBold, .h2)
                    Text("3 meetings today")
                        .lexendFont(.light,.h4)
                }
                Spacer()
                continueButtonView
            }
            Divider()
            Text("4 Seater | Monitor available | Projector")
                .lexendFont(.light,.h5)
                .foregroundStyle(Color.placeholderColor)
        }
        .padding()
        .border(Color.placeholderColor.opacity(0.3), width: 1)
    }
    
    var continueButtonView: some View {
        Button {
            isLoading.toggle()
        } label: {
            continueContentView
                .padding([.top, .bottom], 10)
                .foregroundStyle(.white)
                .lexendFont(.light,.h4)
                .background(Color.brandColor)
                .frame(width: 90)
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
                Text("Book")
            }
            Spacer()
        }
    }
}

#Preview {
    MeetingCardView()
        .padding()
}
