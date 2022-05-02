//
//  RegisterAvailability.swift
//  Helper
//
//  Created by Annie Huynh on 18.4.2022.
//

import SwiftUI

struct RegisterAvailability: View {
    
    @Binding var fullname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var password: String
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ZStack(alignment: .top){
                    Color("Background").edgesIgnoringSafeArea(.all)
                    VStack{
                        ZStack(alignment: .top){
                            Image("BG Mask").edgesIgnoringSafeArea(.all)
                            Text("Select your availability")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .frame(maxWidth: geometry.size.width * 0.7, alignment: .center)
                                .foregroundColor(.white)
                        }
                        .offset(y:-60)
                        
                        Spacer()
                        Text("By signup and login, I confirm that I have read and agree to  Helpers Terms & Privacy Policy")
                            .bold()
                            .frame(maxWidth: 280)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .padding(.bottom, 10)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.7)
                            .shadow(radius: 5)
                            .padding(.top, 60)
                        AvailabilityForm(fullname: $fullname, email: $email, phone: $phone, password: $password)
                            .padding(.top, 80)
                    }
                    .offset(y:-50)
                }
            }
        }
    }
}

struct RegisterAvailability_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAvailability(fullname: .constant(""), email: .constant(""), phone: .constant(""), password: .constant(""))
    }
}
