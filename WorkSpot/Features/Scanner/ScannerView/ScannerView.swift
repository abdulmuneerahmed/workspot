//
//  ScannerView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 24/07/24.
//

import SwiftUI
import VisionKit

struct ScannerView: View {
    @State var scanResult = ""
    @StateObject var viewModal = ScannerViewModal()

    var body: some View {
        ZStack(alignment: .bottom) {
            QRScanner(result: $scanResult)
            continueButtonView
        }
    }
    
    var continueButtonView: some View {
        ZStack {
            Button {
                viewModal.isLoading.toggle()
            } label: {
                continueContentView
                    .padding()
                    .foregroundStyle(.white)
                    .lexendFont(.light)
                    .background(Color.brandColor.opacity(isvalidID ? 1 : 0.5))
                    .frame(maxWidth: .infinity)
            }
            .hide(if: isvalidID)
            .disabled(viewModal.isLoading)
        }
        .foregroundStyle(Color.white)
    }
    
    private var isvalidID: Bool {
        scanResult.isEmpty
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
            if  viewModal.isLoading {
                progressView
            } else {
                Text("Continue")
            }
            Spacer()
        }
    }
}


#Preview {
    ScannerView()
}

