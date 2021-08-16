//
//  EditAccountView.swift
//  GameOn
//
//  Created by Andika on 11/08/21.
//

import SwiftUI

struct EditAccountView: View {
    @ObservedObject var accountViewModel: AccountViewModel

    var body: some View {
        List {
            Section(header: Text(LocalizedStringKey("PERSONAL_DETAILS"))) {
                HStack {
                    Spacer()

                    Image("icn.profile-empty")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 128)
                        .clipShape(Circle())
                        .padding(.vertical)

                    Spacer()
                }

                TextField(LocalizedStringKey("USER_NAME"), text: $accountViewModel.name)

                Picker(selection: $accountViewModel.gamerLevel, label: Text(LocalizedStringKey("GAMER_LEVEL"))) {
                    ForEach(accountViewModel.gamerLevels, id: \.self) { level in
                        Text(LocalizedStringKey(level))
                    }
                }
            }

            Section(header: Text(LocalizedStringKey("SOCIAL_DETAILS"))) {
                HStack {
                    SVGRendererComponent(name: "icn.store-steam")
                        .frame(height: 32)
                        .padding(8)

                    TextField(LocalizedStringKey("STEAM_USERNAME"), text: $accountViewModel.steamName)
                        .autocapitalization(.none)
                }

                HStack {
                    SVGRendererComponent(name: "icn.store-egs")
                        .frame(height: 32)
                        .padding(8)

                    TextField(LocalizedStringKey("EGS_USERNAME"), text: $accountViewModel.egsName)
                        .autocapitalization(.none)
                }
            }

            Section(header: Text(LocalizedStringKey("SHARING_OPTIONS"))) {
                Toggle("ENABLE_GC_SHARING", isOn: $accountViewModel.gameCodeSharing)

                if accountViewModel.gameCodeSharing {
                    Toggle("ENABLE_GC_FAVORITE_SHARING", isOn: $accountViewModel.shareFavorites)
                }
            }
        }.listStyle(GroupedListStyle())
        .navigationBarTitle(LocalizedStringKey("MY_PROFILE"), displayMode: .inline)
    }
}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView(accountViewModel: AccountViewModel())
    }
}
