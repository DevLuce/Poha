//
//  CircleImage.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("구룡포항"))
    }
}
