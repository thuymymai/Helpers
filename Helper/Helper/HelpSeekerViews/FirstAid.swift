//
//  FirstAid.swift
//  Helper
//
//  Created by Mai Thuỳ My on 12.4.2022.
//

import SwiftUI

struct FirstAid: View {
    @Binding var stt: Int
    let array = [Firstaid.Choking, Firstaid.BrokenBone, Firstaid.Allergy, Firstaid.BeeStings, Firstaid.Bleeding, Firstaid.Burns, Firstaid.Drowning, Firstaid.ElectricShock, Firstaid.HeartAttack, Firstaid.Hypothermia, Firstaid.NoseBleeds, Firstaid.Posoning, Firstaid.Sprains, Firstaid.Stroke]
    
    var body: some View {
        switch(stt) {
        case 1: Text("\(array[0].rawValue)")
        case 2: Text("\(array[1].rawValue)")
        default:
            Text("Choke")
        }
    }
}

struct FirstAid_Previews: PreviewProvider {
    static var previews: some View {
        FirstAid(stt: .constant(0))
    }
}
