//
//  GeminiView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import SwiftUI
import GoogleGenerativeAI

struct GeminiView: View {
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GeminiView()
}
