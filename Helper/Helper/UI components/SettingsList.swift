//
//  SettingsList.swift contains setting item that is used in the two types of user profile
//  Helper
//
//  Created by Annie Huynh on 28.4.2022.
//

import SwiftUI

struct SettingsView: View {
    var name: String
    var body: some View {
        Button(action: {
        }){
            HStack {
                Text(name)
                Spacer(minLength: 15)
            }.padding()
                .font(.headline)
                .foregroundColor(Color.black.opacity(0.6))
        }
    }
}


