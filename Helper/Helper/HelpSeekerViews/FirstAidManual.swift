//
//  FirstAdManual.swift
//  Helper
//
//  Created by Dang Son on 2.5.2022.
//

import SwiftUI

struct FirstAidManual: View {
    let array = [Firstaid.Choking, Firstaid.BrokenBone, Firstaid.Allergy, Firstaid.BeeStings, Firstaid.Bleeding, Firstaid.Burns, Firstaid.Drowning, Firstaid.ElectricShock, Firstaid.HeartAttack, Firstaid.Hypothermia, Firstaid.NoseBleeds, Firstaid.Poisoning, Firstaid.Sprains, Firstaid.Stroke]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(array, id: \.self) { firstaid in
                    NavigationLink {
                        FirstAid(stt: firstaid) }
                    label: {
                        ZStack{
                            Rectangle()
                                .fill(Color("Background"))
                                .frame(width: 150, height: 120)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            VStack{
                                Text("\(String(describing: firstaid))")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: 120, alignment: .leading)
                                    .font(.system(size: 16))
                                HStack{
                                    Image(systemName: "arrow.right.circle.fill")
                                        .frame(maxWidth: 60, alignment: .leading)
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Primary"))
                                        .padding(.top)
                                    Image("firstaid")
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .frame(height: 150)
        }
        .padding()
    }
}
