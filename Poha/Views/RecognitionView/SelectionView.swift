//
//  SelectionView.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct SelectionView: View {
    @State var isCameraPressed: Bool = false
    @State var isPickerPressed: Bool = false
    @State var image: UIImage? = nil
    @State var isImageSet: Bool = false
    
    var body: some View {
        ZStack {
            Color("PrimaryColor")
                .ignoresSafeArea()
            VStack {
                NavigationLink(isActive: $isImageSet ) {
                    if image != nil {
                        ResultView(image: image!)
                            .onDisappear {
                                image = nil
                                isImageSet = false
                            }
                    }
                } label: {
                    HStack {
                        RoundedSquareButton(systemName: "camera.fill") {
                            isCameraPressed = true
                        }
                        .padding()
                        
                        RoundedSquareButton(systemName: "photo.fill") {
                            isPickerPressed = true
                        }
                        .padding()
                    }
                }
                Text("사진을 통해 어떤 랜드마크인지 알아보세요!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationTitle("랜드마크 사진 인식")
        .fullScreenCover(isPresented: $isCameraPressed) {
            CameraView(image: $image)
                .onDisappear {
                    if image != nil {
                        isImageSet = true
                    } else {
                        isImageSet = false
                    }
                }
        }
        .fullScreenCover(isPresented: $isPickerPressed) {
            PhotoPickerView(image: $image)
                .onDisappear {
                    if image != nil {
                        isImageSet = true
                    } else {
                        isImageSet = false
                    }
                }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
