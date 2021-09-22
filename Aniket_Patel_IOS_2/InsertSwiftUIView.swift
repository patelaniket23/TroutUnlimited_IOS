//
//  InsertSwiftUIView.swift
//  Aniket_Patel_IOS_2
//
//  Created by Aniket Patel on 2021-08-15.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct InsertSwiftUIView: View {
    
    @State var airTemperature = ""
    @State var waterTemperature = ""
    @State private var isPresented = false
    
    @State var buttonCorner : CGFloat = 10
    @State var buttonColor = Color.green

    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
            
            VStack {
                TextField("Air Temperature", text: $airTemperature)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("Water Temperature", text: $waterTemperature)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                /*...............Notification.............**/
              
                Button(action: {
                                   self.isPresented = true
                    self.buttonColor = self.buttonColor == Color.green ? Color.red :Color.green
                    self.buttonCorner = self.buttonCorner == 10 ? 50 : 10

                               }) {
                                   Text("Notify")
                                       .alert(isPresented: $isPresented, content : {
                                        Alert(title: Text("SpotData"), message: Text("Generating Notification"), primaryButton: .default(Text("Ok")) {
                                            print("Ok")
                                        }, secondaryButton: .cancel() {
                                            print("Cancel")
                                            Notification.generateNotification(title: "SpotData", description: "This is Notification")
                                        })
                                       
                                              
                                       })
                               
                                       .padding()
                                       .frame(width: 220, height: 55, alignment: .center)
                                    .foregroundColor(Color.black)
                                       .background(buttonColor)
                                       .font(.system(size: 25))
                                       .cornerRadius(buttonCorner)
                } .animation(.spring(response: 0.5, dampingFraction: 2, blendDuration: 0.5))
                    
                /*................Notification ends*************/
                
                /*..................Insert button.............**/
                Button(action: {
                    guard !airTemperature.isEmpty, !waterTemperature.isEmpty else {
                        return
                    }
                   // viewModel.signIn(email: email, password: password)
                }, label: {
                    NavigationLink("Insert", destination: UploadSwiftUIView())
                        .padding()
                        .frame(width: 220, height: 55, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                        .cornerRadius(10)
                        
                }
                )
                /*..................Insert button end.............**/

                /* ..............Sensors.............*/
                
                NavigationLink(destination: Sensors()) {
                    Text("Go to Sensors")
                        .padding()
                        .frame(width: 220, height: 55, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                        .cornerRadius(10)
                    
                }
                /* ................Sensors ends.................*/
                
                /*.............Notification...........**/
//
//                Button(action: {
//                                   self.isPresented = true
//                               }, label: {
//                                   Text("Upload")
//                                       .alert(isPresented: $isPresented, content : {
//                                           Alert(title: Text("SpotData"), message: Text("Generating Notification"), primaryButton: .default(Text("Ok")), secondaryButton: .cancel())
//
//                                       })
//
//                                       .padding()
//                                       .frame(width: 220, height: 55, alignment: .center)
//                                       .background(Color.green)
//                                       .font(.system(size: 25))
//                                       .cornerRadius(10)
//                               })
    
//                NavigationLink("Create Account", destination: SignUpView())
//                    .padding()
                /* .................Notification ends............*/
            }
            .padding()
            Spacer()
            
        }
        .navigationTitle("Insert Data")

    }

    
}


struct InsertSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InsertSwiftUIView()
    }
}
