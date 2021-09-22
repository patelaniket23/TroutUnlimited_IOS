//
//  Sensors.swift
//  Aniket_Patel_IOS_2
//
//  Created by Aniket Patel on 2021-08-20.
//

import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private let locationManager: CLLocationManager
    
// Initializing and requesting functions
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}

struct Sensors: View {
    @StateObject var locationViewModel = LocationViewModel()
       
       var body: some View {
           switch locationViewModel.authorizationStatus {
           case .notDetermined:
               AnyView(RequestLocationView())
                   .environmentObject(locationViewModel)
           case .restricted:
               ErrorView(errorText: "Location use is restricted.")
           case .denied:
               ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
           case .authorizedAlways, .authorizedWhenInUse:
               TrackingView()
                   .environmentObject(locationViewModel)
           default:
               Text("Unexpected status")
           }
       }
}
// Requesting a location
struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow my location", systemImage: "location")
            })
            
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("Your permission needed to access your location.")
                .foregroundColor(.orange)
                .font(.caption)
            
        }
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
    }
}

struct TrackingView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        Text("Thank you for your location")
    }
}

struct Sensors_Previews: PreviewProvider {
    static var previews: some View {
        Sensors()
    }
}
