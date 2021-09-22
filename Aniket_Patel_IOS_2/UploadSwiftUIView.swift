//
//  UploadSwiftUIView.swift
//  Aniket_Patel_IOS_2
//
//  Created by Aniket Patel on 2021-08-15.
//

import SwiftUI
import Foundation
import UserNotifications

struct UploadSwiftUIView: View {
    
    @State var angle = 0.0
    @State var slideShowRunning = false
    @State var imageName = "play"
    
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    @State var slidesImages = ["trout1", "trout2", "trout3", "trout4"]
    
    var body: some View {
        VStack (spacing: 60){
            Text("These are some species of trout.")
                .padding()
            Image(slidesImages[0])
                .resizable()
                .aspectRatio(UIImage(named: "trout1")!.size, contentMode: .fit)
                .onReceive(timer, perform: {
                    arg in print ("timer")
                    if (self.slideShowRunning) {
                        //self.slidesImages.append(self.slidesImages.removeFirst())
                        self.slidesImages.shuffle()
                    }
                })
            Button (action: {
                self.angle += 360.0
                if (self.slideShowRunning) {
                    self.slideShowRunning = false
                    self.imageName = "play"
                } else {
                    self.slideShowRunning = true
                    self.imageName = "pause"
                }
            }) {
                Image(systemName: imageName)
                    .padding(.all, 20.0)

            }
            .border(Color.green, width: 1.5)
            .animation(
                Animation.easeInOut(duration : 2)
                    .delay(2)
            )
            .rotationEffect(Angle(degrees: angle))

        }
    }
}

struct UploadSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        UploadSwiftUIView()
    }
}
