//
//  RoundedSquareButton.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct RoundedSquareButton: View {
    var backgroundColor: Color
    var foregroundColor: Color
    
    private let systemName: String
    private let action: () -> Void
    
    // It would be nice to make this into a binding.
    private let disabled: Bool
    
    init(systemName: String,
         disabled: Bool = false,
         backgroundColor: Color = Color("SecondaryColor"),
         foregroundColor: Color = Color.white,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.systemName = systemName
        self.action = action
        self.disabled = disabled
    }
    
    var body: some View {
        Button(action:self.action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .padding()
        }
        .buttonStyle(
            LargeButtonStyle(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                isDisabled: disabled)
        )
        .disabled(self.disabled)
    }
}

struct RoundedSquareButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            RoundedSquareButton(systemName: "camera.fill") {
                
            }
            RoundedSquareButton(systemName: "photo.fill") {
                
            }
        }
    }
}
