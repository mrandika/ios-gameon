//
//  DeveloperInfoView.swift
//  GameOn
//
//  Created by Andika on 14/08/21.
//

import SwiftUI

struct DeveloperInfoView: View {
    var body: some View {
        List {
            Section(header: Text(LocalizedStringKey("PERSONAL_DETAILS"))) {
                HStack {
                    Image("Account")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 128)
                        .clipShape(Circle())
                        .padding(.vertical)
                        .padding(.trailing)

                    VStack(alignment: .leading) {
                        Text("Muhammad Rizki Andika")
                            .bold()
                            .padding(.bottom, 8)

                        Text("Telkom University")
                    }
                }
            }
        }.listStyle(GroupedListStyle())
        .navigationBarTitle(LocalizedStringKey("DEVELOPER_INFO"), displayMode: .inline)
    }
}

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperInfoView()
    }
}
