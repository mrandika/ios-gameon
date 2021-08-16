//
//  BackgroundImageView.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BackgroundImageView: View {
    var imageUrl: URL

    var body: some View {
        WebImage(url: imageUrl)
            .placeholder {
                Image("BackgroundEmpty")
                    .resizable()
                    .scaledToFill()
            }
            .resizable()
            .renderingMode(.original)
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView(imageUrl: URL(string:
                                            "https://media.rawg.io/media/games/c4b/c4b0cab189e73432de3a250d8cf1c84e.jpg"
        )!)
    }
}
