//
//  SuggestionReviewComponent.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI

struct SuggestionReviewComponent: View {
    var suggestionsCount: Int
    var reviewsCount: Int

    var body: some View {
        VStack(alignment: .trailing) {
            Image(systemName: "hand.thumbsup.fill")
                .renderingMode(.template)
                .foregroundColor(.systemIndigo)
                .font(.system(size: 16))
                .padding(.bottom, 8)

            Text(LocalizedStringKey("\(suggestionsCount) SUGGESTION_COUNT"))
                .padding(.bottom)

            Text(LocalizedStringKey("\(reviewsCount) REVIEWS"))
                .font(.body)
                .foregroundColor(.systemGray)
        }.padding(.trailing)
    }
}

struct SuggestionReviewComponent_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionReviewComponent(suggestionsCount: 100, reviewsCount: 100)
            .previewLayout(.sizeThatFits)
    }
}
