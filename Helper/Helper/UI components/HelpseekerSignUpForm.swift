//
//  Forms.swift contains the form components that are used in the two types of user signup view
//  Helper
//
//  Created by My Mai, Dang Son, An Huynh on 28.4.2022.
//

import SwiftUI
import AVFoundation
import Speech

struct HelpseekerSignUpForm: View {
    @State var fullname: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirm: String = ""
    
    @State private var isLinkActive = false
    @State private var signupFailed = false
    @State private var showAlert: Bool = false
    @State private var passwordFailed = false
    @State private var emptyField = false
    @State private var emailCheck = false
    @State private var phoneCheck = false
    
    // state of button
    @State var btnFullName = false
    @State var btnPhone = false
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    @State private var text: String? = ""

    let audioEngine = AVAudioEngine()
    let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    @State var task : SFSpeechRecognitionTask!
    var isStart : Bool = false
    
    // start voice
    func startSpeechRecognization(){
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            let _ = print("Error comes here for starting the audio listner =\(error.localizedDescription)")
        }
        
        guard let myRecognization = SFSpeechRecognizer() else {
            let _ = print("Recognization is not allow on your local")
            return
        }
        
        if !myRecognization.isAvailable {
            let _ = print("Recognization is free right now, Please try again after some time.")
        }
        
        self.task = speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
            guard let response = response else {
                if error != nil {
                    let _ = print(error.debugDescription)
                } else {
                    let _ = print("Problem in giving the response")
                }
                return
            }
            
            // get transcipt
            let message = response.bestTranscription.formattedString
            if self.btnFullName {
                self.fullname = message
            } else if self.btnPhone {
                self.phone = message
            }
        })
    }
    
    // stop voice
    func cancelSpeechRecognization() {
        task.finish()
        task.cancel()
        task = nil
        
        request.endAudio()
        audioEngine.stop()
        
        //MARK: UPDATED
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Text("Full name")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                HStack {
                    TextField("", text: $fullname)
                        .padding(.bottom, 20)
                        .background(Color("Background"))
                        .cornerRadius(5)
                    Button {
                        self.btnFullName.toggle()
                        if (self.btnFullName) {
                            self.text = ""
                            startSpeechRecognization()
                        } else {
                            cancelSpeechRecognization()
                            self.text = ""
                        }
                    } label: {
                        Label("", systemImage: "mic")
                    }
                }
                .background(Color("Background"))
                .cornerRadius(5)
                Text("Email")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                HStack {
                    TextField("", text: $email)
                        .padding(.bottom, 20)
                        .background(Color("Background"))
                        .cornerRadius(5)
                } .background(Color("Background"))
                    .cornerRadius(5)
                
                Text("Phone number")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                HStack {
                    TextField("", text: $phone)
                        .padding(.bottom, 20)
                        .background(Color("Background"))
                        .cornerRadius(5)
                    Button {
                        self.btnPhone.toggle()
                        if (self.btnPhone) {
                            self.text = ""
                            startSpeechRecognization()
                        } else {
                            cancelSpeechRecognization()
                            self.text = ""
                        }
                    } label: {
                        Label("", systemImage: "mic")
                    }
                }.background(Color("Background"))
                    .cornerRadius(5)
                Text("Password")
                    .fontWeight(.medium)
                    .frame(alignment: .leading)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                SecureField("", text: $password)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Confirm Password")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                SecureField("", text: $confirm)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
            }
            .frame(width: 260)
            .padding(.top, 50)
            
            NavigationLink( destination: MedicalInfo(fullname: $fullname, email: $email, phone: $phone, password: $password)
                .navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
            Button(action: {
                let userExists = results.map{$0.email?.lowercased()}.contains(email.lowercased())
                self.signupFailed = false
                if (userExists){
                    self.signupFailed.toggle()
                }
                self.emptyField = false
                if(fullname == "" || email == "" || phone == ""  || password == "" || confirm == "") {
                    self.emptyField.toggle()
                }
                self.emailCheck = false
                if(email.isValidEmail == false) {
                    self.emailCheck.toggle()
                }
                self.phoneCheck = false
                if(phone.isNumber == false) {
                    self.phoneCheck.toggle()
                }
                self.passwordFailed = false
                if(confirm != password){
                    self.passwordFailed.toggle()
                }
                self.showAlert.toggle()
            }) {
                Text("NEXT")
                    .font(.system(size: 16))
                    .foregroundColor(Color("Primary"))
                    .fontWeight(.bold)
                    .frame(width: 90, height: 50)
                Image(systemName: "arrow.forward.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("Primary"))
                
            }
            .padding(.top, 550)
            .frame(alignment: .trailing)
            .alert(isPresented: $showAlert, content: {
                // alert when there is error
                if self.signupFailed {
                    return Alert(title: Text("Sign up failed"), message: Text("Email already taken!"), dismissButton: .default(Text("Try again")))
                } else if self.emptyField {
                    return Alert(title: Text("Sign up failed"), message: Text("All fields are required!"), dismissButton: .default(Text("Try again")))
                } else if self.emailCheck {
                    return Alert(title: Text("Sign up failed"), message: Text("Please enter valid email!"), dismissButton: .default(Text("Try again")))
                } else if self.phoneCheck {
                    return Alert(title: Text("Sign up failed"), message: Text("Phone must be number!"), dismissButton: .default(Text("Try again")))
                } else if self.passwordFailed {
                    return Alert(title: Text("Sign up failed"), message: Text("Passwords do not match!"), dismissButton: .default(Text("Try again")))
                } else {
                    // alert when successfull and go to next page
                    return  Alert(title: Text("Success!"), message: Text("You have set up your basic information!"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                }
            })
        }
    }
}

// check valid email
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

//check valid phone number
extension String {
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
