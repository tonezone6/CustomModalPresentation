import SwiftUI

extension View {
    ///
    /// View presentation wrapping UIKit modal presentation
    /// style and transition
    func fullscreenModal<Content: View>(
        isPresented: Binding<Bool>,
        presentationStyle: UIModalPresentationStyle = .overFullScreen,
        transitionStyle: UIModalTransitionStyle = .crossDissolve,
        content: @escaping () -> Content
    ) -> some View {
        self.modifier(
            FullScreenModalViewModifier(
                isPresented: isPresented,
                modalPresentationStyle: presentationStyle,
                modalTransitionStyle: transitionStyle,
                presentedContent: content
            )
        )
    }
}

struct FullScreenModalViewModifier<PresentedContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let modalPresentationStyle: UIModalPresentationStyle
    let modalTransitionStyle: UIModalTransitionStyle
    let presentedContent: () -> PresentedContent
    
    func body(content: Content) -> some View {
        content.background(
            FullScreenModalController(
                isPresented: $isPresented,
                modalPresentationStyle: modalPresentationStyle,
                modalTransitionStyle: modalTransitionStyle,
                content: {
                    presentedContent()
                }
            )
        )
    }
}

struct FullScreenModalController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let modalPresentationStyle: UIModalPresentationStyle
    let modalTransitionStyle: UIModalTransitionStyle
    let content: () -> Content
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let hostingController = UIHostingController(rootView: content())
            hostingController.view.backgroundColor = .clear
            hostingController.modalPresentationStyle = modalPresentationStyle
            hostingController.modalTransitionStyle = modalTransitionStyle
            uiViewController.present(hostingController, animated: true)
            
            DispatchQueue.main.async {
                isPresented = false  // Reset after presenting
            }
        }
    }
}
