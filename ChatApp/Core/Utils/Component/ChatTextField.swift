//
//  ChatTextField.swift
//  ChatApp
//
//  Created by Jason Ngo on 24/05/2024.
//

import SwiftUI
import SwiftUI


class UIChatTextField: UITextField {
    
    var isEmoji = false {
        didSet {
            setEmoji()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setEmoji() {
        self.reloadInputViews()
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" && self.isEmoji{
                self.keyboardType = .default
                return mode
                
            } else if !self.isEmoji {
                return mode
            }
        }
        return nil
    }
    
}

struct ChatTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    @Binding var isEmoji: Bool
    
    func makeUIView(context: Context) -> UIChatTextField {
        let emojiTextField = UIChatTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        emojiTextField.isEmoji = self.isEmoji
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIChatTextField, context: Context) {
        uiView.text = text
        uiView.isEmoji = isEmoji
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: ChatTextField
        
        init(parent: ChatTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
