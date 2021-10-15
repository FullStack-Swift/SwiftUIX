import SwiftUI
#if canImport(PathBuilder)
struct AnyShape: Shape {
  
  private let path: Path
  
  /// Initializes path using custom attribute path builder.
  init(@PathBuilder builder: () -> Path) {
    self.path = builder()
  }
  
  func path(in rect: CGRect) -> Path {
    path
  }
  
}
#endif
