//
//  PhotoPickerView.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var image : UIImage?
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        let viewController = PHPickerViewController(configuration: config)
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> PhotoPickerView.Coordinator {
        return Coordinator(self)
    }
}

extension PhotoPickerView {
    
    class Coordinator: NSObject,
                       PHPickerViewControllerDelegate {
        private let window: UIWindow
        var parent: PhotoPickerView
        
        init(_ parent: PhotoPickerView) {
            self.parent = parent
            self.window = UIWindow()
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let result = results.first else {
                return
            }

            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let error = error {
                    print("Photo picker error: \(error)")
                    return
                }

                guard let photo = object as? UIImage else {
                    fatalError("The Photo Picker's image isn't a/n \(UIImage.self) instance.")
                }
                
                self.parent.image = photo
            }
        }
        
        
    }
}
