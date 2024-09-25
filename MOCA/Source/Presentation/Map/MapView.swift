//
//  MapView.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
}

#Preview {
    MapView()
}
