//
//  FirstAid.swift
//  Helper
//
//  Created by Mai Thuỳ My on 12.4.2022.
//

import SwiftUI

struct FirstAid: View {
    var stt: Firstaid
    let array = [Firstaid.Choking, Firstaid.BrokenBone, Firstaid.Allergy, Firstaid.BeeStings, Firstaid.Bleeding, Firstaid.Burns, Firstaid.Drowning, Firstaid.ElectricShock, Firstaid.HeartAttack, Firstaid.Hypothermia, Firstaid.NoseBleeds, Firstaid.Poisoning, Firstaid.Sprains, Firstaid.Stroke]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("White")
                .edgesIgnoringSafeArea(.all)
            ForEach(array, id: \.self) { value in
                if (value == stt) {
                    ScrollView {
                        VStack(spacing:20) {
                        Text("\(String(describing: value))")
                            .bold()
                            .font(.system(size: 22))
                            .foregroundColor(Color("Primary"))
                        Text("\(value.rawValue)")
                            .font(.system(size: 18))
                            .padding()
                    }.offset(y:-30)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(10)
                    }
                }
            }
        }
    }
}

struct FirstAid_Previews: PreviewProvider {
    static var previews: some View {
        FirstAid(stt: Firstaid.Choking)
    }
}
