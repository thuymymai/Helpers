//
//  UploadForm.swift
//  Helper
//
//  Created by Mai Thuỳ My on 12.4.2022.
//

import SwiftUI

struct UploadForm: View {
    @Binding var helpseekerName: String
    @State var userId: Int = 0
    @State var locationUser: String = ""
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    func getUserInfo() {
        let userInfo = results.filter{$0.fullname?.lowercased() == helpseekerName.lowercased() }
        
        if(userInfo.count > 0){
            self.userId = Int(userInfo[0].userId)
            self.locationUser = userInfo[0].location!
        }
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.top)
                
                VStack{
                    ZStack(alignment: .top) {
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("Need help?")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Text("Fill in the form to find volunteer")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }.padding(.top, -30)
                    }
                    Spacer()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.9)
                        .shadow(radius: 5)
                        .padding(.top, 50)
                    FormTask(userId: $userId, locationUser: $locationUser)
                }
                .padding(.bottom, 10)
                
            }
            .onAppear(perform: {getUserInfo()})
        }
    }
}

struct UploadForm_Previews: PreviewProvider {
    static var previews: some View {
        UploadForm(helpseekerName: .constant(""))
    }
}
