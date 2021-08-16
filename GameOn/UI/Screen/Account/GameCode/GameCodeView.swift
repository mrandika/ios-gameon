//
//  GameCodeView.swift
//  GameOn
//
//  Created by Andika on 11/08/21.
//

import SwiftUI
import CarBode
import SlideOverCard

struct GameCodeView: View {
    @ObservedObject var accountViewModel: AccountViewModel

    @State var showScanner: Bool = false

    @State var gameCodeProfile: Profile = Profile.fake
    @State var foundGameCode: Bool = false

    var body: some View {
        ZStack {
            ScrollView {
                if !accountViewModel.gameCodeSharing {
                    VStack {
                        Image("icn.gamecode-disabled")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 256)
                            .padding(.bottom)

                        Text(LocalizedStringKey("GAMECODE_DISABLED"))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.systemGray)
                    }
                } else {
                    VStack {
                        if accountViewModel.isProfileComplete() {
                            CBBarcodeView(data: .constant(accountViewModel.gameCodeData()),
                                          barcodeType: .constant(CBBarcodeView.BarcodeType.qrCode),
                                          orientation: .constant(CBBarcodeView.Orientation.up)) { _ in
                                //
                            }.frame(width: 256, height: 256)
                            .padding(.bottom)

                            Text(LocalizedStringKey("GAMECODE_TUTORIAL"))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.systemGray)
                        } else {
                            Image("icn.gamecode-empty")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 256)
                                .padding(.bottom)

                            Text(LocalizedStringKey("PROFILE_NOT_COMPLETE_GAMECODE"))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.systemGray)
                        }
                    }
                }
            }

            VStack {
                Spacer()

                NavigationLink(
                    destination: GameCodeProfileView(profile: gameCodeProfile),
                    isActive: $foundGameCode,
                    label: {
                        EmptyView()
                    })

                Button(action: {
                    showScanner.toggle()
                }, label: {
                    HStack {
                        Spacer()

                        Text(LocalizedStringKey("SCAN"))
                            .foregroundColor(.white)
                            .bold()
                            .padding(.vertical, 2)

                        Spacer()
                    }.padding()
                    .background(Color.systemIndigo)
                    .cornerRadius(10)
                })
            }.padding(.bottom)

        }.padding()
        .slideOverCard(isPresented: $showScanner, content: {
            VStack {
                Text(LocalizedStringKey("SCAN_GAMECODE"))
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 4)

                Text(LocalizedStringKey("GAMECODE_SCAN_INSTRUCTION"))
                    .foregroundColor(.systemGray)
                    .padding(.bottom)

                CBScanner(supportBarcode: .constant([.qr]),
                          scanInterval: .constant(5.0)) {
                    gameCodeProfile = accountViewModel.decodeGameData(data: $0.value.data(using: .utf8) ?? Data())

                    if !accountViewModel.isError {
                        foundGameCode.toggle()
                    }

                    showScanner.toggle()
                }.aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .cornerRadius(10)
            }
        }).alert(isPresented: $accountViewModel.showAlert, content: {
            Alert(title: Text(LocalizedStringKey("GAMECODE_INVALID")),
                  message: Text(LocalizedStringKey(
                                    accountViewModel.error?.localizedDescription ?? "GAMECODE_INVALID_DESCRIPTION")),
                  dismissButton: .default(Text(LocalizedStringKey("OK"))))
        })
        .navigationBarTitle(LocalizedStringKey("MY_GAMECODE"), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameCodeView_Previews: PreviewProvider {
    static var previews: some View {
        GameCodeView(accountViewModel: AccountViewModel())
    }
}
