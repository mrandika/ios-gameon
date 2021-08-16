//
//  LicenseView.swift
//  GameOn
//
//  Created by Andika on 14/08/21.
//

import SwiftUI

// swiftlint:disable line_length
struct LicenseView: View {
    var body: some View {
        List {
            LicenseDataView(name: "SDWebImageSwiftUI", license: "MIT License", url: "https://github.com/SDWebImage/SDWebImageSwiftUI", description: "This library provides an async image downloader with cache support. The framework provide the different View structs, which API match the SwiftUI framework guideline. If you're familiar with Image, you'll find it easy to use WebImage and AnimatedImage.")

            LicenseDataView(name: "SwiftUIX", license: "MIT License", url: "https://github.com/SwiftUIX/SwiftUIX", description: "SwiftUIX attempts to fill the gaps of the still nascent SwiftUI framework, providing an extensive suite of components, extensions and utilities to complement the standard library. This project is by far the most complete port of missing UIKit/AppKit functionality, striving to deliver it in the most Apple-like fashion possible.")

            LicenseDataView(name: "CarBode", license: "MIT License", url: "https://github.com/heart/CarBode-Barcode-Scanner-For-SwiftUI", description: "Free and Opensource Barcode scanner & Barcode generator for SwiftUI.")
            LicenseDataView(name: "SlideOverCard", license: "MIT License", url: "https://github.com/joogps/SlideOverCard", description: "A SwiftUI card design, similar to the one used by Apple in HomeKit, AirPods, Apple Card and AirTag setup, NFC scanning, Wi-Fi password sharing and more. It is specially great for setup interactions.")
        }.navigationBarTitle(LocalizedStringKey("LICENSES"), displayMode: .inline)
    }
}
// swiftlint:enable line_length

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}

struct LicenseDataView: View {

    var name: String
    var license: String
    var url: String
    var description: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(.title2)
                    .bold()

                Spacer()

                Text(license)
            }.padding(.bottom, 1)

            Text(url)
                .font(.system(size: 14))
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 4)
                .fixedSize(horizontal: false, vertical: true)

            Text(description)
                .font(.body)
                .foregroundColor(.systemGray)
        }.padding(.vertical)
    }
}
