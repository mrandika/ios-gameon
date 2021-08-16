//
//  SmallBackgroundImage.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct SmallBackgroundImage: View {
    var imageUrl: URL

    var body: some View {
        BackgroundImageView(imageUrl: imageUrl)
            .frame(width: 300, height: 169)
            .scaledToFit()
            .cornerRadius(5)
    }
}

struct SmallBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        SmallBackgroundImage(imageUrl: URL(string:
                                            "https://media.rawg.io/media/games/c4b/c4b0cab189e73432de3a250d8cf1c84e.jpg"
        )!)
            .previewLayout(.sizeThatFits)
    }
}
