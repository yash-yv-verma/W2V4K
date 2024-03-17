//
//  WelcomeView.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/14/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var name = ""
    @State private var initial = ""
    @State private var gradeLevel = 1 // Default grade level
    
    let gradeLevels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] // Example grade levels
    
    @State private var isSubmitted = false // Track whether the user has submitted the form
    @State private var shouldNavigateToContent = false // Track whether to navigate to ContentView
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Enter your information")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 20) // Add top padding
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 60) // Add horizontal padding
                    .foregroundColor(.orange) // Change text color to orange
                    .frame(maxWidth: .infinity) // Adjusts width based on available space
                    
                
                TextField("Initial", text: $initial)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 60) // Add horizontal padding
                    .foregroundColor(.orange) // Change text color to orange
                    .frame(maxWidth: .infinity) // Adjusts width based on available space
                
                Picker("Grade Level", selection: $gradeLevel) {
                    ForEach(gradeLevels, id: \.self) { level in
                        Text("\(level)")
                            .foregroundStyle(Color.orange)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .padding(.horizontal, 60) // Add horizontal padding
                .frame(maxWidth: .infinity) // Adjusts width based on available space
                .foregroundColor(.blue)
                
                Button("Submit") {
                    submitForm()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .disabled(name.isEmpty || initial.isEmpty)
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .padding()
        }
        .sheet(isPresented: $shouldNavigateToContent) {
            ContentView()
        }
    }
    
    private func submitForm() {
        // Validate input and create user object
        guard !name.isEmpty, let initialChar = initial.first else {
            print("Please enter name and initial")
            return
        }
        
        let newUser = User(name: name, initial: initialChar, gradeLevel: gradeLevel)
        print("User: \(newUser)")
        isSubmitted = true
        shouldNavigateToContent = true
        
        // Create the folder
        let fileManager = FileManager.default
        let folderPath = "/Users/yshvrm/Documents/Courses/Independent Study/Students/" // Your file path here
        
        do {
            // Create folder name based on user information
            let folderName = "\(name)-\(initialChar)-\(gradeLevel)"
            // Construct the full URL for the new directory
            let folderURL = URL(fileURLWithPath: folderPath).appendingPathComponent(folderName)
            // Create the directory
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            print("Directory created: \(folderURL.path)")
            
            // Capture and save the screenshot
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            let filename = "\(timestamp).png"
            let fileURL = folderURL.appendingPathComponent(filename)
            
            // Capture screenshot of the entire screen
            guard let windowImage = CGWindowListCreateImage(.infinite, .optionOnScreenOnly, kCGNullWindowID, [.bestResolution, .nominalResolution]) else {
                print("Failed to capture screenshot")
                return
            }
            
            // Convert the CGImage to NSImage
            let nsImage = NSImage(cgImage: windowImage, size: .zero)
            
            // Convert NSImage to Data (PNG format)
            guard let pngData = nsImage.tiffRepresentation else {
                print("Failed to convert NSImage to TIFF representation")
                return
            }
            
            // Write PNG data to file
            try pngData.write(to: fileURL)
            print("Screenshot saved to: \(fileURL.path)")
        } catch {
            print("Error creating directory or saving screenshot: \(error)")
        }
    }
}
