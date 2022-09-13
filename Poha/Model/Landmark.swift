//
//  landmark.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case gonggong = "공공기관"
        case sanjing = "지역상징성"
        case culture = "문화유산"
        case museum = "전시관"
        case building = "건물"
        case siseol = "시설"
        case myeongso = "명소"
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var featureImage: Image? {
        isFeatured ? Image(imageName) : nil
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
