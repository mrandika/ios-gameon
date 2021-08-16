//
//  PlatformSelectionView.swift
//  GameOn
//
//  Created by Andika on 13/08/21.
//

import SwiftUI

struct PlatformSelectionView: View {
    @ObservedObject var platformViewModel = PlatformViewModel.shared

    var body: some View {
        VStack {
            Text(LocalizedStringKey("PLATFORM_SELECTION"))
                .font(.title)
                .bold()
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)

            Text(LocalizedStringKey("PLATFORM_SELECTION_DESCRIPTION"))
                .font(.body)
                .foregroundColor(.systemGray)
                .multilineTextAlignment(.center)
                .padding(.bottom)

            Spacer()

            if platformViewModel.isLoading {
                LoadingComponent(title: LocalizedStringKey("GETTING_PLATFORMS"))
            } else if platformViewModel.isError {
                ErrorComponent(errorMessage: LocalizedStringKey(platformViewModel.error?.localizedDescription ??
                                                                    "UNKNOWN_ERROR"))
            } else {
                ScrollView {
                    ForEach(platformViewModel.platforms, id: \.platformId) { platform in
                        VStack {
                            HStack {
                                Text(platform.name)

                                Spacer()

                                Image(systemName: platformViewModel.isPlatformSelected(
                                        platform: platform) ? "circle" : "checkmark.circle.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 23)
                                    .foregroundColor(.systemIndigo)
                            }

                            Divider()
                        }.padding()
                        .onTapGesture {
                            platformViewModel.appendOrRemovePlatform(platform: platform)
                        }
                    }
                }
            }

            Spacer()

            Button(action: {
                platformViewModel.provideDefaultPlatforms()
            }, label: {
                HStack {
                    Spacer()

                    Text(LocalizedStringKey("RESET_SELECTION"))

                    Spacer()
                }
            }).padding()
            .foregroundColor(.systemIndigo)
            .background(Color.systemIndigo.opacity(0.25))
            .cornerRadius(10)
        }.padding()
        .onAppear {
            platformViewModel.fetchPlatforms()
        }
        .onDisappear {
            PlatformGameViewModel.shared.games = [:]
            PlatformGameViewModel.shared.fetchPlatform(platforms: platformViewModel.selectedPlatforms)
        }.alert(isPresented: $platformViewModel.showAlert, content: {
            Alert(title: Text(LocalizedStringKey(platformViewModel.alertTitle)),
                  message: Text(LocalizedStringKey(platformViewModel.alertMessage)),
                  dismissButton: .default(Text(LocalizedStringKey("OK"))))
        })
    }
}

struct PlatformSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformSelectionView()
    }
}
