//
//  MedicalInfo.swift
//  Helper
//
//  Created by Mai Thuỳ My on 11.4.2022.
//

import SwiftUI

struct MedicalInfo: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background").edgesIgnoringSafeArea(.all)
                VStack{
                    ZStack(alignment: .top) {
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        Text("Medical information")
                            .fontWeight(.medium)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .padding(.top, 50)
                    }
                    Spacer()
                    Text("By signup and login, I confirm I am at least  17 years old, and I agree to and accept  Helpers Terms & Privacy Policy")
                        .frame(maxWidth: 280)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 15))
                        .padding(.bottom, 30)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 300, height: 500)
                        .shadow(radius: 5)
                    FormMedical()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct MedicalInfo_Previews: PreviewProvider {
    static var previews: some View {
        MedicalInfo()
    }
}

struct SpecialNeed: View {
    @State private var selection = "Immobilized"
    let specialNeeds = ["Autism", "Down syndrome", "Blindness", "Deafness", "Immobilized", "ADHD"]
    
    var body: some View {
        Picker("Select need", selection: $selection) {
            ForEach(specialNeeds, id: \.self) {
                Text($0)
                    .frame(width: 110, height: 110)
                    .background(.blue)
            }
        }
        .pickerStyle(.menu)
    }
}

struct ChronicDiseases: View {
    @State private var selection = "Heart disease"
    let diseases = ["Heart disease", "Stroke", "Cancer", "Depression", "Diabetes", "Arthritis", "Asthma", "Oral disease"]
    
    var body: some View {
        Picker("Select disease", selection: $selection) {
            ForEach(diseases, id: \.self) {
                Text($0)
                    .frame(width: 110, height: 110)
                    .background(.blue)
            }
        }.pickerStyle(.menu)
    }
}

struct Allergies: View {
    @State private var selection = "Pollen"
    let diseases = ["Grass", "Pollen", "Dust mites", "Animal dander", "Nuts", "Gluten", "Lactose", "Mould"]
    
    var body: some View {
        Picker("Select disease", selection: $selection) {
            ForEach(diseases, id: \.self) {
                Text($0)
                    .frame(width: 110, height: 110)
                    .background(.blue)
            }
        }
        .pickerStyle(.menu)
        .frame(alignment: .leading)
    }
}

struct FormMedical: View {
    @State var info: String = ""
    @State var isLinkActive = false
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                VStack {
                    Text("Special needs")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                    SpecialNeed()
                    Text("Chronic diseases")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    ChronicDiseases()
                    Text("Allergies")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    Allergies()
                    Text("Others")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    TextField("", text: $info)
                        .padding(.bottom, 40)
                        .background(Color("Background"))
                        .cornerRadius(5)
                }
                .frame(width: 250)
                NavigationLink(destination: HelpSeekerNavBar().navigationBarHidden(true), isActive: self.$isLinkActive) { }
                Button(action: {
                    showAlert.toggle()
                }) {
                    Text("REGISTER")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                        .frame(width: 100, height: 35)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Register successfully!"),  dismissButton: .default(Text("Got it!"), action: {self.isLinkActive = true}))
                })
                .padding(.top, 40)
            }
            
        }
        
    }
}
