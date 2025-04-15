import SwiftUI

extension View {
    func fullScreenModal<Content: View>(
        isPresented: Binding<Bool>,
        presentationStyle: UIModalPresentationStyle = .overFullScreen,
        transitionStyle: UIModalTransitionStyle = .crossDissolve,
        content: @escaping () -> Content
    ) -> some View {
        self.modifier(
            FullScreenModalViewModifier(
                isPresented: isPresented,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                presentationContent: content
            )
        )
    }
}

struct FullScreenModalViewModifier<PresentationContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let presentationStyle: UIModalPresentationStyle
    let transitionStyle: UIModalTransitionStyle
    let presentationContent: () -> PresentationContent
    
    func body(content: Content) -> some View {
        content.background(
            FullScreenModalView(
                isPresented: $isPresented,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                content: presentationContent
            )
        )
    }
    
    struct FullScreenModalView<Content: View>: UIViewControllerRepresentable {
        @Binding var isPresented: Bool
        let presentationStyle: UIModalPresentationStyle
        let transitionStyle: UIModalTransitionStyle
        let content: () -> Content
        
        func makeUIViewController(context: Context) -> UIViewController {
            let viewController = UIViewController()
            viewController.view.backgroundColor = .clear
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            if isPresented {
                let uiHostingController = UIHostingController(rootView: content())
                uiHostingController.view.backgroundColor = .clear
                uiHostingController.modalPresentationStyle = presentationStyle
                uiHostingController.modalTransitionStyle = transitionStyle
                uiViewController.present(uiHostingController, animated: true)
            } else {
                uiViewController.dismiss(animated: true)
            }
        }
    }
}
