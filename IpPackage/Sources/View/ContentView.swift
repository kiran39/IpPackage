//
//  File.swift
//  
//
//  Created by Kiran Kumar on 07/01/24.
//
//
//  ContentView.swift
//  FindMyIP

import SwiftUI
@available(iOS 14.0, *)
struct ContentView: View {
    @StateObject private var viewModel = IPViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching IP Address...")
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    Text("Your IP Address is \(viewModel.ipAddress)")
                }
            }
        }
        .onAppear {
            viewModel.fetchIPAddress()
        }
    }
}
