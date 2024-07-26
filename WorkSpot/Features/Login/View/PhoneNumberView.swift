//
//  PhoneNumberView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 24/07/24.
//

import SwiftUI

struct PhoneNumberView: View {
    @State var phoneNumber: String = ""
    @State var isLoading = false
    @FocusState var focus: Bool
    var body: some View {
        VStack(spacing: WorkSpotSpacing.spacingSize32) {
            phoneNumberContent
            continueButtonView
        }
        .padding([.leading,.trailing],
            WorkSpotSpacing.spacingSize20)
    }
    
    var phoneNumberContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Phone number")
                .foregroundStyle(Color.placeholderColor)
                .lexendFont(.light,.h6)
            HStack {
                ZStack {
                    Text("+91")
                        .lexendFont(.light)
                        .foregroundStyle(Color.blacktextColor)
                }
                .padding()
                .border(isvalidID ? Color.brandColor : Color.placeholderColor, width: 1)
                phoneNumberView
            }
        }
    }
    
    var phoneNumberView: some View {
        TextFieldView(text: $phoneNumber, placeholder: "")
            .focused($focus)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focus.toggle()
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
        phoneNumber.count == 10
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
                Text("SignIn")
            }
            Spacer()
        }
    }
}

#Preview {
    PhoneNumberView()
}
