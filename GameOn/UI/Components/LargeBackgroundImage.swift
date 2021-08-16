//
//  LargeBackgroundImage.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct LargeBackgroundImage: View {
    var imageUrl: URL

    var body: some View {
        BackgroundImageView(imageUrl: imageUrl)
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
            .cornerRadius(5)
    }
}

struct LargeBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        LargeBackgroundImage(imageUrl: URL(string:
                                            "https://media.rawg.io/media/games/c4b/c4b0cab189e73432de3a250d8cf1c84e.jpg"
        )!)
            .previewLayout(.sizeThatFits)
    }
}
