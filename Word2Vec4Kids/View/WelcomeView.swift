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
                    .padding(.horizontal) // Add horizontal padding
                    .foregroundColor(.orange) // Change text color to orange
                    .frame(maxWidth: .infinity) // Adjusts width based on available space
                
                TextField("Initial", text: $initial)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Add horizontal padding
                    .foregroundColor(.orange) // Change text color to orange
                    .frame(maxWidth: .infinity) // Adjusts width based on available space
                
                Picker("Grade Level", selection: $gradeLevel) {
                    ForEach(gradeLevels, id: \.self) { level in
                        Text("\(level)")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .padding(.horizontal) // Add horizontal padding
                .frame(maxWidth: .infinity) // Adjusts width based on available space
                
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
        let documentsURL = URL(fileURLWithPath: "/Users/yshvrm/Documents/Courses/Independent Study/Students/")
        
        do {
            // Create folder name based on user information
            let folderName = "\(name)-\(initialChar)-\(gradeLevel)"
            // Construct the full URL for the new directory
            let folderURL = documentsURL.appendingPathComponent(folderName)
            // Create the directory
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            print("Directory created: \(folderURL.path)")
        } catch {
            print("Error creating directory: \(error)")
        }
    }

}
