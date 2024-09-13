//
//  ToastView.swift
//  MotaNet
//
//  Created by sam hastings on 13/09/2024.
//

import SwiftUI

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}

enum ToastStyle {
  case error
  case warning
  case success
  case info
}

extension ToastStyle {
  var themeColor: Color {
    switch self {
    case .error: return Color.red
    case .warning: return Color.orange
    case .info: return Color.blue
    case .success: return Color.green
    }
  }
  
  var iconFileName: String {
    switch self {
    case .info: return "info.circle.fill"
    case .warning: return "exclamationmark.triangle.fill"
    case .success: return "checkmark.circle.fill"
    case .error: return "xmark.circle.fill"
    }
  }
}



struct ToastView: View {
  
  var style: ToastStyle
  var message: String
  var width = CGFloat.infinity
  var onCancelTapped: (() -> Void)
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      Image(systemName: style.iconFileName)
        .foregroundColor(style.themeColor)
      Text(message)
        .font(Font.caption)
        .foregroundColor(.black)
      
      Spacer(minLength: 10)
      
      Button {
        onCancelTapped()
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(style.themeColor)
      }
    }
    .padding()
    .frame(minWidth: 0, maxWidth: width)
    .background(.white)//style.themeColor.opacity(0.1))
    .cornerRadius(8)

    .overlay( // Adding a border with a rounded rectangle
        RoundedRectangle(cornerRadius: 8)
            .stroke(style.themeColor, lineWidth: 1) // Border color and width
    )
    .padding(.horizontal, 16)
  }
}

struct ToastModifier: ViewModifier {
  
  @Binding var toast: Toast?
  @State private var workItem: DispatchWorkItem?
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(
        ZStack {
          mainToastView()
            .offset(y: 32)
        }.animation(.spring(), value: toast)
      )
      .onChange(of: toast) { _, _ in
        showToast()
      }
  }
  
  @ViewBuilder func mainToastView() -> some View {
    if let toast = toast {
      VStack {
        ToastView(
          style: toast.style,
          message: toast.message,
          width: toast.width
        ) {
          dismissToast()
        }
        Spacer()
      }
    }
  }
  
  private func showToast() {
    guard let toast = toast else { return }
    
    UIImpactFeedbackGenerator(style: .light)
      .impactOccurred()
    
    if toast.duration > 0 {
      workItem?.cancel()
      
      let task = DispatchWorkItem {
        dismissToast()
      }
      
      workItem = task
      DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
    }
  }
  
  private func dismissToast() {
    withAnimation {
      toast = nil
    }
    
    workItem?.cancel()
    workItem = nil
  }
}

struct DummyView: View {
    @State private var toast: Toast? = nil
    
    var body: some View {
        VStack(spacing: 32) {
              Button {
                toast = Toast(style: .success, message: "Saved.", width: 160)
              } label: {
                Text("Run (Success)")
              }
              
              Button {
                toast = Toast(style: .info, message: "Btw, you are a good person.")
              } label: {
                Text("Run (Info)")
              }
              
              Button {
                toast = Toast(style: .warning, message: "Beware of a dog!")
              } label: {
                Text("Run (Warning)")
              }
              
              Button {
                toast = Toast(style: .error, message: "Fatal error, blue screen level.")
              } label: {
                Text("Run (Error)")
              }
              
            }
            .toastView(toast: $toast)
    }
}

#Preview {
    DummyView()
}
