//
//  RoundedImage.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct RoundedImage: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 10)
    }
}

struct RoundedImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImage(image: Image("구룡포항"))
    }
}
