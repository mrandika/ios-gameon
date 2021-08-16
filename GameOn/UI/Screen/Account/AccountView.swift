//
//  AccountView.swift
//  GameOn
//
//  Created by Andika on 10/08/21.
//

import SwiftUI

struct AccountView: View {
    @Environment (\.presentationMode) var presentationMode

    @ObservedObject var accountViewModel: AccountViewModel
    @ObservedObject var favoriteGameViewModel = FavoriteGameViewModel.shared

    @State var showAlert: Bool = false

    var body: some View {
        NavigationView {
            List {
                ProfileSectionView(accountViewModel: accountViewModel, content: {
                    Group {
                        NavigationLink(
                            destination: EditAccountView(accountViewModel: accountViewModel),
                            label: {
                                HStack(alignment: .center) {
                                    Image("icn.profile-empty")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 56)
                                        .clipShape(Circle())
                                        .padding(.trailing)

                                    VStack(alignment: .leading) {
                                        Text(accountViewModel.name.isEmpty ||
                                                accountViewModel.name == "" ? "-" :
                                                accountViewModel.name)
                                            .bold()
                                            .padding(.bottom, 1)

                                        Text(LocalizedStringKey(accountViewModel.gamerLevel))
                                            .font(.callout)
                                            .foregroundColor(.systemGray)
                                    }
                                }.padding()
                            })

                        NavigationLink(
                            destination: GameCodeView(accountViewModel: accountViewModel),
                            label: {
                                Text(LocalizedStringKey("GAMECODE"))
                            })
                    }
                })

                Section(header: Text(LocalizedStringKey("SETTINGS"))) {
                    NavigationLink(
                        destination: PlatformSelectionView(),
                        label: {
                            Text("🎮 \(Text(LocalizedStringKey("GAME_PLATFORM")))")
                        })
                }

                Section(header: Text(LocalizedStringKey("GENERAL"))) {
                    NavigationLink(
                        destination: LicenseView(),
                        label: {
                            Text("👩🏻‍⚖️ \(Text(LocalizedStringKey("SOFTWARE_LICENSE")))")
                        })

                    NavigationLink(
                        destination: DeveloperInfoView(),
                        label: {
                            Text("👨🏻‍💻 \(Text(LocalizedStringKey("MEET_THE_DEVELOPER")))")
                        })
                }

                Section {
                    Button(action: {
                        showAlert.toggle()
                    }, label: {
                        Text(LocalizedStringKey("RESET_FAVORITE_GAMES"))
                            .foregroundColor(.systemRed)
                    })
                }
            }.listStyle(GroupedListStyle())
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(LocalizedStringKey("CONFIRMATION_RESET_FAVORITES")),
                      message: Text(LocalizedStringKey("CONFIRMATION_MESSAGE_RESET_FAVORITES")),
                      primaryButton: .destructive(Text(LocalizedStringKey("YES")),
                                                  action: {
                        PersistenceController.shared.resetFavorite()
                        favoriteGameViewModel.fetch()
                }), secondaryButton: .cancel(Text(LocalizedStringKey("CANCEL"))))
            })
            .navigationBarTitle(LocalizedStringKey("ACCOUNT"), displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar(content: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(LocalizedStringKey("DONE"))
                })
            })
        }.accentColor(.systemIndigo)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(accountViewModel: AccountViewModel())
    }
}

// swiftlint:disable line_length
struct ProfileSectionView<Content: View>: View {
    @ObservedObject var accountViewModel: AccountViewModel
    var content: () -> Content

    var body: some View {
        if accountViewModel.isProfileComplete() {
            Section(header: Text(LocalizedStringKey("MY_PROFILE"))) {
                content()
            }
        } else {
            Section(header: Text(LocalizedStringKey("MY_PROFILE")), footer: Text(LocalizedStringKey("COMPLETE_PROFILE_FEATURES"))) {
                content()
            }
        }
    }
}
// swiftlint:enable line_length
