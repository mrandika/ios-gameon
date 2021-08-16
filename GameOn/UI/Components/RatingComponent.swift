//
//  RatingComponent.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI

struct RatingComponent: View {
    var rating: Double
    var ratingTop: Int

    var body: some View {
        VStack {
            Text(String(format: "%.1f", round(rating)))
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .bold()
                .padding(.top, 4)

            Text(LocalizedStringKey("OUT_OF_RATE \(ratingTop)"))
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .bold()
                .foregroundColor(.systemGray)
        }
    }
}

struct RatingComponent_Previews: PreviewProvider {
    static var previews: some View {
        RatingComponent(rating: 4.8, ratingTop: 5)
            .previewLayout(.sizeThatFits)
    }
}
