//
//  ViewExtensions.swift
//  MotaNet
//
//  Created by sam hastings on 13/09/2024.
//

import SwiftUI

extension View {

  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
