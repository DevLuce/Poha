//
//  CameraView.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import Foundation
import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    @Binding var image : UIImage?
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self)
    }
}

extension CameraView {
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] else {
                fatalError("Picker didn't have an original image.")
            }

            guard let photo = originalImage as? UIImage else {
                fatalError("The (Camera) Image Picker's image isn't a/n \(UIImage.self) instance.")
            }
            
            self.parent.image = photo
        }
    }
}
