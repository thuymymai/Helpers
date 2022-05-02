//
//  MedicalInfo.swift
//  Helper
//
//  Created by Mai Thuỳ My on 11.4.2022.
//

import SwiftUI
import CoreData

struct MedicalInfo: View {
    @Binding var fullname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var password: String
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack{
                    Color("Background").edgesIgnoringSafeArea(.all)
                    VStack{
                        ZStack(alignment: .top) {
                            Image("BG Mask").edgesIgnoringSafeArea(.all)
                            Text("Medical information")
                                .fontWeight(.medium)
                                .frame(maxWidth: geometry.size.width * 0.7, alignment: .center)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                .padding(.top, 50)
                        }.offset(y:-60)
                        Spacer()
                        Text("By signup and login, I confirm that I am at least 17 years old and agree to  Helpers Terms & Privacy Policy")
                            .bold()
                            .frame(maxWidth: 280)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .padding(.bottom, 25)
                        
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.65)
                            .shadow(radius: 5)
                        FormMedical(fullname: $fullname, email: $email, phone: $phone, password: $password)
                    }
                    .offset(y:-30)
                }
                
            }
        }
    }
}

struct MedicalInfo_Previews: PreviewProvider {
    static var previews: some View {
        MedicalInfo(fullname: .constant(""), email: .constant(""), phone: .constant(""), password: .constant(""))
    }
}
