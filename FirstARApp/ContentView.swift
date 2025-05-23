//
//  ContentView.swift
//  FirstARApp
//
//  Created by Development on 2025/05/19.
//

import RealityKit
import SwiftUI

struct ContentView: View {
    @State var isCubeRed = false

    var body: some View {
        RealityView { content in
            // Create a cube model
            let model = Entity()
            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
            let color: UIColor = isCubeRed ? .red : .gray
            let material = SimpleMaterial(color: color, roughness: 0.15, isMetallic: true)
            model.components.set(ModelComponent(mesh: mesh, materials: [material]))
            model.position = [0, 0.05, 0]

            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
            anchor.addChild(model)

            // Add the horizontal plane anchor to the scene
            content.add(anchor)

            content.camera = .spatialTracking
        }
        .edgesIgnoringSafeArea(.all)
        .id(isCubeRed) // 追加: isCubeRedが変わるたびに再描画
        .onTapGesture {
            isCubeRed = true
        }
    }
}
