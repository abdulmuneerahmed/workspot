//
//  LoginVIew.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 18/07/24.
//

import SwiftUI

struct LoginVIew: View {
    @State var employeeID: String = ""
    @FocusState private var textViewActive: Bool
    @State var isLoading = false
    var body: some View {
        VStack(alignment: .leading ,spacing: WorkSpotSpacing.spacingSize24) {
            headingTitleDetails
            employeeIDTextView
            continueButtonView
        }
        .padding([.leading,.trailing],
            WorkSpotSpacing.spacingSize24)
    }
    
    var headingTitleDetails: some View {
        VStack(alignment: .leading) {
            Text("Welcome to \(Text("WorkSpot").foregroundColor(Color.brandColor))")
                .lexendFont(.medium, .h1)
                .foregroundStyle(Color.blacktextColor)
            Text("Hello there, enter your employee Id to continue.")
                .lexendFont(.light,.h6)
                .foregroundStyle(Color.placeholderColor)
        }
    }

    var employeeIDTextView: some View {
        TextFieldView(text: $employeeID, placeholder: "employee Id")
            .defaultFocus($textViewActive, true)
            .focused($textViewActive)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        textViewActive.toggle()
                    } label: {
                        Text("Done")
                            .lexendFont(.light)
                            .foregroundStyle(Color.brandColor)
                    }
                }
            }
    }
    
    var continueButtonView: some View {
        Button {
            isLoading.toggle()
        } label: {
            continueContentView
                .padding()
                .foregroundStyle(.white)
                .lexendFont(.light)
                .background(Color.brandColor.opacity(isvalidID ? 1 : 0.5))
                .frame(maxWidth: .infinity)
        }
        .disabled(isLoading || !isvalidID)
    }
    
    private var isvalidID: Bool {
        employeeID.count >= 7
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
                Text("Continue")
            }
            Spacer()
        }
    }
}

#Preview {
    LoginVIew(employeeID: "")
}
