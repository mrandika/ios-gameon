//
//  OnboardingView.swift
//  GameOn
//
//  Created by Andika on 08/08/21.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var stateObservable: StateObservable

    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 64)
                .padding(.vertical)

            Text(LocalizedStringKey("WELCOME_TEXT"))
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 32)
                .multilineTextAlignment(.center)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    OnboardingCell(image: "star.fill",
                                   imageColor: .systemYellow,
                                   title: LocalizedStringKey("ONBOARDING_TOP_RATED"),
                                   description: LocalizedStringKey("ONBOARDING_TOP_RATED_DESCRIPTION"))

                    OnboardingCell(image: "heart.fill",
                                   imageColor: .systemRed,
                                   title: LocalizedStringKey("ONBOARDING_FAVORITE"),
                                   description: LocalizedStringKey("ONBOARDING_FAVORITE_DESCRIPTION"))

                    OnboardingCell(image: "qrcode.viewfinder",
                                   imageColor: .systemIndigo,
                                   title: LocalizedStringKey("ONBOARDING_GAMECODE"),
                                   description: LocalizedStringKey("ONBOARDING_GAMECODE_DESCRIPTION"))

                    OnboardingCell(image: "magnifyingglass",
                                   imageColor: .systemGreen,
                                   title: LocalizedStringKey("ONBOARDING_SEARCH"),
                                   description: LocalizedStringKey("ONBOARDING_SEARCH_DESCRIPTION"))
                }
            }

            Spacer()

            Button(action: {
                stateObservable.passOnboarding()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Spacer()

                    Text(LocalizedStringKey("NEXT"))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical, 2)

                    Spacer()
                }.padding()
                .background(Color.systemIndigo)
                .cornerRadius(10)
            })
        }.padding(.horizontal, 32)
        .padding(.vertical)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(stateObservable: StateObservable())
    }
}

struct OnboardingCell: View {
    var image: String
    var imageColor: Color

    var title: LocalizedStringKey
    var description: LocalizedStringKey

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: image)
                .renderingMode(.template)
                .font(.system(size: 32))
                .foregroundColor(imageColor)
                .padding(.bottom)
                .padding(.trailing)

            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .padding(.bottom, 1)

                Text(description)
                    .font(.body)
            }
        }.padding(.bottom, 32)
    }
}
