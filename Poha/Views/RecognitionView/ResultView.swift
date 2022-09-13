//
//  ResultView.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modelData: ModelData
    
    let image: UIImage
    let imagePredictor = ImagePredictor()
    
    let predictionsToShow = 2
    @State var predictionLabel: String = ""
    @State var selection: Int? = nil
    @State var landmark: Landmark?
    
    var body: some View {
        ZStack {
            Color("PrimaryColor")
                .ignoresSafeArea()
            VStack {
                Spacer()
                RoundedImage(image: Image(uiImage: image))
                    .padding()
                Text(predictionLabel)
                    .font(.title)
                Spacer()
                if landmark != nil {
                    NavigationLink(destination: LandmarkDetail(landmark: landmark ?? modelData.landmarks[0]), tag: 1, selection: $selection) {
                        RoundedLargeButton(title: "자세히 알아보기") {
                            selection = 1
                        }
                    }
                    
                }
                RoundedLargeButton(title: "인식 다시하기", backgroundColor: Color("CancelColor")) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            classifyImage(image)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(image: UIImage(named: "구룡포항")!)
            .environmentObject(ModelData())
    }
}


extension ResultView {
    
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            predictionLabel = "랜드마크 인식 불가"
            return
        }

        //let formattedPredictions = formatPredictions(predictions)
        //let predictionString = formattedPredictions.joined(separator: "\n")
        //print(predictionString)
        
        let target = predictions[0]
        
        let confidence = target.confidencePercentage.components(separatedBy: CharacterSet.init(charactersIn: "0123456789.").inverted).joined(separator: "")
        
        print(confidence)
        
        if Float(confidence) ?? 0 > 85 {
            var name = target.classification

            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }
            
            predictionLabel = name
            self.landmark = modelData.landmarks.first {
                $0.name == name
            }
        } else {
            predictionLabel = "랜드마크 인식 불가"
        }
        
        
    }

    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
}
