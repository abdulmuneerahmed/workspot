//
//  TextfieldView.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 18/07/24.
//

import SwiftUI

//TODO: add TextField validation logic
struct TextFieldView: View {
    @Binding var text: String
    var placeholder: String = "Placeholder"
    var keyboardType: UIKeyboardType = .numberPad
    var returnKeyType: UIReturnKeyType = .default
    var onCommit: (() -> Void)?
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder)
                .foregroundStyle(Color.placeholderColor)
                .lexendFont(.light,.h6)
                .hide(if: placeholder.isEmpty)
            TextField("", text: $text, onEditingChanged: { editing in
                isEditing = editing
            }, onCommit: {
                if let onCommit = onCommit {
                    onCommit()
                }
            })
            .keyboardType(keyboardType)
            .textContentType(.none)
            .disableAutocorrection(true)
            .padding()
            .lexendFont(.light)
            .foregroundStyle(Color.blacktextColor)
            .background(RoundedRectangle(cornerRadius: 0).stroke(text.count >= 7  ? Color.brandColor : Color.textfieldborderColor, lineWidth: 1))
            //TODO: Remove hard coded 'Count >= 7'
        }
    }
}

#Preview {
    TextFieldView(text: .constant("5605405"))
        .padding(16)
}
