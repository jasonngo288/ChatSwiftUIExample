//
//  ImagePickerView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import Foundation
import SwiftUI

enum ImagePickerSourceType {
    case photoLibrary
    case camera
    case savedPhotosAlbum
    case none
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    private var sourceType: ImagePickerSourceType
    private let onImagePicked: (UIImage) -> Void
    private let onDismiss: () -> Void

    @Environment(\.dismiss) private var pickerDismiss
    
    public init(sourceType: ImagePickerSourceType, onImagePicked: @escaping (UIImage) -> Void, onDismiss: @escaping () -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
        self.onDismiss = onDismiss
    }
    
    func transferSourceType(type: ImagePickerSourceType) -> UIImagePickerController.SourceType {
        switch type {
        case .photoLibrary:
            return .photoLibrary
        case .camera:
            return .camera
        case .savedPhotosAlbum:
            return .savedPhotosAlbum
        default:
            return .photoLibrary
        }
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let topMost = UIViewController.topMost

        let picker = UIImagePickerController()
        picker.sourceType = transferSourceType(type: self.sourceType)
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: {
                self.pickerDismiss()
                self.onDismiss()
            },
            onImagePicked: self.onImagePicked
        )
    }
    
    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void
        
        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }
        
        public func imagePickerController(_ picker: UIImagePickerController,
                                          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }
        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }
    }
}

extension UIViewController {
    static var topMost: UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
