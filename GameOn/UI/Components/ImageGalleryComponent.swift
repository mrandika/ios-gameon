//
//  ImageGalleryComponent.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI

struct ImageGalleryComponent: View {
    var gameScreenshot: [ShortScreenshot]

    var body: some View {
        VStack(alignment: .leading) {
            InformationCellView(title: LocalizedStringKey("SCREENSHOTS")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(gameScreenshot, id: \.screenshotId) { screenshot in
                        BackgroundImageView(imageUrl: screenshot.screenshotUrl)
                            .frame(width: 300, height: 169)
                            .cornerRadius(5)
                            .padding(.leading)
                            .padding(.trailing, 2)
                        }
                    }.frame(height: 169)
                }
            }
        }
    }
}

struct ImageGalleryComponent_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryComponent(gameScreenshot: Game.fake.shortScreenshots!)
            .previewLayout(.sizeThatFits)
    }
}
