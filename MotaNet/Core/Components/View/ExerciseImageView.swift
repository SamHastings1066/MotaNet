//
//  ExerciseImageView.swift
//  MotaNet
//
//  Created by sam hastings on 10/08/2024.
//

import SwiftUI

enum ExerciseImageSize {
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .small:
            80
        case .medium:
            120
        case .large:
            150
        }
    }
}

struct ExerciseImageView: View {
    let imageURLs: [String]
    let size: ExerciseImageSize
    var body: some View {
        if let image = UIImage(named: imageURLs[0]) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } else {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(.gray)
                .overlay(alignment: .center) {             Image(systemName: "figure.run")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.dimension * 0.8, height: size.dimension * 0.8)
                        .foregroundStyle(Color(.white))
                }
        }
    }
}

#Preview {
    Group {
        ExerciseImageView(imageURLs: Exercise.MOCK_EXERCISES[0].images, size: .small).padding()
        ExerciseImageView(imageURLs: Exercise.MOCK_EXERCISES[1].images, size: .small)
    }
}
