//
//  ContentView.swift
//  Aniket_Patel_IOS_2
//
//  Created by Aniket Patel on 2021-08-14.
//

import SwiftUI
import FirebaseAuth


class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    //whenever we change this it is connected to contentview which can help us to change in realtime
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
               return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
               return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }

        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}


struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
        
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                VStack {
                    Text("You are already signed in.")
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                    })
                }
            }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
    
    struct SignInView: View {
        
        @EnvironmentObject var viewModel: AppViewModel
        
        @State var email = ""
        @State var password = ""
        
        var body: some View {
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        NavigationLink("Sign In", destination: InsertSwiftUIView())
                            .padding()
                            .frame(width: 220, height: 55, alignment: .center)
                            .background(Color.green)
                            .font(.system(size: 25))
                            .cornerRadius(10)
                    })
                    
                    NavigationLink("Don't Have A Account, Create One", destination: SignUpView())
                        .padding()
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Sign In")
            
        }
    }

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
            
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Create Account")
                        .padding()
                        .frame(width: 220, height: 55, alignment: .center)
                        .background(Color.green)
                        .font(.system(size: 25))
                        .cornerRadius(10)
                })
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Create Account")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

