//
//  UploadForm.swift
//  Helper
//
//  Created by Mai Thuỳ My on 12.4.2022.
//

import SwiftUI

struct UploadForm: View {
    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                Color("Background").edgesIgnoringSafeArea(.all)
                VStack{
                    ZStack(alignment: .top) {
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("Need help?")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Text("Fill in the form to find volunteer")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }.padding(.top, -50)
                    }
                    Spacer()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 300, height: 600)
                        .shadow(radius: 5)
                        .padding(.top, 50)
                    FormTask()
                }
                
            }
        }
    }
}

struct UploadForm_Previews: PreviewProvider {
    static var previews: some View {
        UploadForm()
    }
}

struct Location: View {
    var body: some View{
        NavigationLink(
            destination: MapView(),
            label: {
                HStack {
                    Text("Choose on map")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(maxWidth: 200, alignment: .leading)
                    Image(systemName: "map")
                        .foregroundColor(.black)
                }
                .frame(width: 230, height: 25)
                .padding(10)
                .background(Color("Background"))
                .cornerRadius(5)
            })
    }
}

struct CategoriesPicker: View {
    @State private var selection = "Groceries"
    let categories = ["Groceries", "Delivery", "Personal assistant", "Transportation", "Housework", "Others"]
    
    var body: some View {
            Picker("Select category", selection: $selection) {
                ForEach(categories, id: \.self) {
                    Text($0)
                        .frame(width: 110, height: 110)
                        .background(.blue)
                }
            }
            .pickerStyle(.menu)
    }
}


struct FormTask: View {
    @State var description: String = ""
    @State var title: String = ""
    @State private var currentDate = Date()
    
    var body: some View {
        ZStack{
            VStack{
                VStack {
                    Text("Title")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                    TextField("", text: $title)
                        .padding(.bottom, 20)
                        .background(Color("Background"))
                        .cornerRadius(5)
                    Text("Location")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    Location()
                    Text("Time")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                    Text("Category")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    CategoriesPicker()
                    Text("Description")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    TextField("", text: $description)
                        .padding(.bottom, 40)
                        .background(Color("Background"))
                        .cornerRadius(5)
                }
                .frame(width: 250)
                .padding(.top, 30)
                HStack{
                    Button(action: {}) {
                        Text("ATTACHMENT")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .frame(width: 120, height: 35)
                            .background(Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {}) {
                        Text("SIGN UP")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .frame(width: 100, height: 35)
                            .background(Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.padding(.top, 30)
                
            }
            
        }
        
    }
}


